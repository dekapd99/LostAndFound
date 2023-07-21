//
//  FirstFormView.swift
//  LostAndfound
//
//  Created by Deka Primatio on 21/07/23.
//

import SwiftUI

struct FirstFormView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    @State private var namaLengkap = ""
    @State private var noHP = ""
    
    //MARK: - BODY
    var body: some View {
        //MARK: - MAIN WRAPPER FOR ICON, TEXT, TEXTFIELD & BUTTON (VSTACK)
        VStack(alignment: .center) {
            Spacer()
            
            //MRT ICON
            VStack(spacing: 50) {
                Image("MRTIcon")
                
                Group {
                    Text("Kamu kehilangan barang? Jangan panik! ") +
                    Text("Tenang saja kami akan bantu kamu menemukannya. ")
                        .foregroundColor(Color("MRTBlue"))
                        .fontWeight(.bold) +
                    Text("Silahkan isi laporan kehilagan berikut!")
                }
                .descriptionStyle()
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
            }//: - MRT ICON
            
            Spacer()
            
            //MARK: - HEADER & TEXTFIELD FORM (VSTACK)
            VStack(alignment: .leading) {
                //FORM NAMA LENGKAP
                Section(header: HStack {
                    Text("Nama Lengkap")
                        .headerStyle()
                }) {
                    HStack {
                        TextField("Nama sesuai KTP", text: $namaLengkap)
                            .foregroundColor(Color.black)
                            .textFieldStyle(.roundedBorder)
                            .overlay(
                                Image(systemName: "xmark.circle.fill")
                                    .padding()
                                    .offset(x: 10)
                                    .foregroundColor(Color.accentColor)
                                    .opacity(namaLengkap.isEmpty ? 0.0 : 1.0)
                                    .onTapGesture {
                                        namaLengkap = ""
                                    },
                                alignment: .trailing
                            ) //: - OVERLAY X MARK FOR DELETE CURRENT TEXT
                    } //: - TEXTFIELD (HSTACK)
                }//: - FORM NAMA LENGKAP
                
                //FORM NOMOR HP
                Section(header: HStack {
                    Text("Nomor HP")
                        .headerStyle()
                }) {
                    HStack {
                        TextField("Contoh: 081234567891", text: $noHP)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                            .overlay(
                                Image(systemName: "xmark.circle.fill")
                                    .padding()
                                    .offset(x: 10)
                                    .foregroundColor(Color.accentColor)
                                    .opacity(noHP.isEmpty ? 0.0 : 1.0) // Corrected to use noHP
                                    .onTapGesture {
                                        noHP = ""
                                    },
                                alignment: .trailing
                            ) //: - OVERLAY X MARK FOR DELETE THE CURRENT TEXT
                    }//: - TEXTFIELD (HSTACK)
                }//: - FORM NOMOR HP
            }//: - HEADER & TEXTFIELD FORM (VSTACK)
            
            Spacer()
            
            //MARK: - BUTTON SELANJUTNYA (VSTACK)
            VStack(alignment: .center) {
                //BUTTON SELANJUTNYA
                Button(action: {
                    // TODO: - NEXT PAGE
                    
                }) {
                    Text("Selanjutnya")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(disableForm ? Color("TextGray") : Color.white)
                        .frame(width: 186, height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .circular)
                                .fill(disableForm ? Color("ButtonGray") : Color("MRTBlue"))
                        )
                }//: - BUTTON SELANJUTNYA
                .disabled(disableForm)
            }//: - BUTTON SELANJUTNYA (VSTACK)
        }
        .padding(23)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        //: - MAIN WRAPPER FOR ICON, TEXT, TEXTFIELD & BUTTON (VSTACK)
    }//: - BODY
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Lost & Found")
            }
            .foregroundColor(.blue)
        }
    }
    
    //MARK: - PRIVATE LOGIC FOR BUTTON TOGGLE (DISABLE FORM)
    var disableForm: Bool {
        namaLengkap.isEmpty || noHP.isEmpty || namaLengkap.count < 3 || noHP.count < 10
    }
}

//MARK: - PREVIEWS
struct FirstFormView_Previews: PreviewProvider {
    static var previews: some View {
        FirstFormView()
    }
}
