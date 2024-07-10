//
//  AuthViewModel.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 06/07/2024.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    // Burasi userSession'i saklayacagimiz yer olacak. Kullanici login oldugunda bu property value'a sahip olacak.
    @Published var userSession: FirebaseAuth.User?
    
    // Burasi Kullanici register olduktan sonra kullaniciyi Profil forografi yukleme ekranina goturecegimiz kisim icin
    @Published var didAuthenticateUser = false
    
    // Burasi profil fotografi yukleme kismi icin
    private var tempUserSession: FirebaseAuth.User?
    
    init() {
        // Buradaki "Auth.auth().currentUser" kodu server tarafini kontrol ediyor kullanici login mi diye.
        self.userSession = Auth.auth().currentUser
        
        print("DEBUG: User session is \(String(describing: self.userSession?.uid))")
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            print("DEBUG: Did log user in..")
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        // Bu kodu yukarida ekledigim firebase uzerinden cekiyorum.
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            // Burada register olurken error ortaya cikiyor mu diye kontrol ediyoruz. Eger cikiyorsa bu error'u yazdiriyoruz.
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
            
            // Kullanici bilgilerini almak ve database'e kaydetmek icin bir data dictionary olusturuyorum.
            let data = [
                "email": email,
                "username": username.lowercased(),
                "fullname": fullname,
                "uid": user.uid
            ]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                }
        }
    }
    
    func signOut() {
        // Burada userSession nil'e esit oldugunda ContentView dosyasi icindeki  "if viewModel.userSession == nil {LoginView()}" kodu calisacak ve kullanici sigout yaptiktan sonra kullaniciya login sayfasi gosterilecek.
        // Bu kullanici kod tarafinda signout yapiyor. Asagidaki kod olmazsa app'i yeniden actigimizda yeniden login olmus gorunuruz cunku bilgisi serverdan cekiyor. Bu nedenle hem server hemde kullanici tarafinda signout yapmamiz gerekiyor.
        userSession = nil
        
        // Bu kod ise server tarafinda signout yapiyor.
        try? Auth.auth().signOut()
    }
    
    // Burasi Profil fotografi yukleme alani ile ilgili
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            // Burada database'deki users datasina gidiyoruz
            Firestore.firestore().collection("users")
                // uid ile dogru profil idsine gidiyoruz
                .document(uid)
                // profil fotografini upload ediyoruz.
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                }
        }
    }
    
}
