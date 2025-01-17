//
//  LaporanView.swift
//  LostAndfound
//
//  Created by Bayu Alif Farisqi on 21/07/23.
//

import SwiftUI

struct LaporanView: View {
    @EnvironmentObject var writevm: WriteViewModel
    @EnvironmentObject var readvm: ReadViewModel

    //DATA TRACK
    @State var tracks: [ComponentTrack] = []
   

    //DATA CARD LAPORAN
    @State var noLaporan: String = "LB140720230408"
    @State var nama: String = "Deka"
    @State var noHp: String = "0897986435"
    @State var jenisBarang: String = "elektronik"
    @State var rutePerjalanan: String = "Lebak Bulus - Duku Atas"
    @State var tanggalKehilangan: Date = Date()
    @State var deskripsiBarang: String = "Earphone hitam merk samsung dengan case"
    @State var detailLokasi: String = "Di peron atau di food court"
    @State var detailWaktu: String = "hari senin pagi jam 10"
    @State var lampiranFoto: String = ""
    @State var statusLaporan: String = "Laporan telah diterima oleh petugas MRT Jakarta."
    @State var colorStatus: String = "green"

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    Color.gray.opacity(0.2)
                    if !(readvm.status1Bool ?? false) || (readvm.status3Bool ?? false) || (readvm.status4Bool ?? false) || (readvm.status5Bool ?? false) || (readvm.status6Bool ?? false) || (readvm.status7Bool ?? false) ||
                        (readvm.laporanBatal ?? false) {
                        // Show the button if readvm.status1Bool is false
                        VStack {
                            Spacer()
                            Group {
                                Text("Kamu kehilangan barang? Jangan panik! ") +
                                Text("Tenang saja kami akan bantu kamu menemukannya. ")
                                    .foregroundColor(Color("MRTBlue"))
                                    .fontWeight(.bold) +
                                Text("Silahkan isi laporan kehilangan berikut!")
                            }
                            .descriptionStyle()
                            .padding(.horizontal, 30)
                            .multilineTextAlignment(.center)

                            Spacer().frame(height: UIScreen.main.bounds.height * 0.08)
                            NavigationLink(destination: FirstFormView(), label: {
                                Text("Buat laporan").activeButtonStyle()
                            })
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            CardLaporan(
                                noLaporan: noLaporan,
                                nama: nama,
                                noHp: noHp,
                                jenisBarang: jenisBarang,
                                rutePerjalanan: rutePerjalanan,
                                tanggalKehilangan: tanggalKehilangan,
                                deskripsiBarang: deskripsiBarang,
                                detailLokasi: detailLokasi,
                                detailWaktu: detailWaktu,
                                lampiranForo: lampiranFoto,
                                statusLaporan: statusLaporan,
                                colorStatus: colorStatus,
                                arrayTrack: tracks
                            )
                        }
                    }
                }

                ZStack {
                    Color.white.frame(height: 15)
                    HStack {
                        Spacer().frame(width: UIScreen.main.bounds.width * 0.093)
                        Circle().foregroundColor(Color("MRTBlue")).frame(width: 5, height: 5)
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                nama = readvm.nama ?? ""
                noHp = readvm.noHp ?? ""
                jenisBarang = readvm.jenisBarang ?? ""
                rutePerjalanan = readvm.rutePerjalanan ?? ""
                detailLokasi = readvm.detailLokasi ?? ""
                detailWaktu = readvm.waktu ?? ""
                deskripsiBarang = readvm.deskripsiBarang ?? ""
//                tanggalKehilangan = readvm.
                    updateTracks()
                }
        }
        .onChange(of: readvm.status1Bool) { newStatus1Bool in
            updateTracks()
        }
        .onChange(of: readvm.status2Bool) { newStatus2Bool in
            updateTracks()
        }
        .onChange(of: readvm.status1Tanggal) { newStatus1Tanggal in
            if let newStatus1Tanggal = newStatus1Tanggal, let newStatus1Waktu = readvm.status1Waktu, tracks.isEmpty {
                updateTracks()
            } else {
                if let index = tracks.firstIndex(where: { $0.trackingTitle == "Laporan Dibuat" }) {
                    tracks[index].dateMonth = newStatus1Tanggal ?? ""
                    tracks[index].time = readvm.status1Waktu ?? ""
                }
            }
        }
        .onChange(of: readvm.nama) { newName in
            nama = newName ?? ""
        }
        .onChange(of: readvm.noHp) { newNoHp in
            noHp = newNoHp ?? ""
        }
        .onChange(of: readvm.jenisBarang) { newJenisBarang in
            jenisBarang = newJenisBarang ?? ""
        }
        .onChange(of: readvm.rutePerjalanan) { newRutePerjalanan in
            rutePerjalanan = newRutePerjalanan ?? ""
        }
        .onChange(of: readvm.detailLokasi) { newDetailLokasi in
            detailLokasi = newDetailLokasi ?? ""
        }
        .onChange(of: readvm.waktu) { newWaktu in
            detailWaktu = newWaktu ?? ""
        }
        .onChange(of: readvm.deskripsiBarang) { newDeskripsiBarang in
            deskripsiBarang = newDeskripsiBarang ?? ""
        }
    }

    private func updateTracks() {
        if let status1Bool = readvm.status1Bool {
            if status1Bool && (readvm.status2Bool ?? false) {
                // Show both tracks when status1Bool is true and status2Bool is true
                tracks = [
                    ComponentTrack(
                        dateMonth: readvm.status2Tanggal ?? "",
                        time: readvm.status2Waktu ?? "",
                        trackingColor: "green",
                        trackingTitle: "Laporan Diterima",
                        trackingDescription: "Laporan telah diterima oleh petugas MRT Jakarta.",
                        trackingIcon: "checkmark.circle.fill",
                        trackingStatus: false
                    ),
                    ComponentTrack(
                        dateMonth: readvm.status1Tanggal ?? "",
                        time: readvm.status1Waktu ?? "",
                        trackingColor: "",
                        trackingTitle: "Laporan Dibuat",
                        trackingDescription: "Laporan telah Dibuat oleh \(readvm.nama ?? "").",
                        trackingIcon: "",
                        trackingStatus: false
                    ),
                ]
                statusLaporan = "Laporan telah diterima oleh petugas MRT Jakarta." // Change the statusLaporan value here

            } else if status1Bool {
                // Show only the "Laporan Dibuat" track when status1Bool is true and status2Bool is false
                tracks = [
                    ComponentTrack(
                        dateMonth: readvm.status1Tanggal ?? "",
                        time: readvm.status1Waktu ?? "",
                        trackingColor: "green",
                        trackingTitle: "Laporan Dibuat",
                        trackingDescription: "Laporan telah dibuat oleh \(readvm.nama ?? "").",
                        trackingIcon: "checkmark.circle.fill",
                        trackingStatus: false
                    )
                ]
                statusLaporan = "Laporan telah dibuat oleh \(readvm.nama ?? "")." // Change the statusLaporan value here

            } else {
                // Show no tracks when both status1Bool and status2Bool are false
                tracks = []
                statusLaporan = "" // Change the statusLaporan value here
            }
        }
    }

}

struct LaporanView_Previews: PreviewProvider {
    static var previews: some View {
        LaporanView()
    }
}
