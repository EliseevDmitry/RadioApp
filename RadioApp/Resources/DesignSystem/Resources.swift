//
//  Resources.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 28.07.2024.
//

import Foundation

enum Resources {
    
    enum Text {
        /// Onboarding
        static let letsGetStarted = "Let’s Get Started"
        static let enjoyTheBestRadio = "Enjoy the best radio stations from your home, don't miss out on anything"
        static let getStarted = "Get Started"
        
        /// SignIn
        enum SignIn {
            static let title = "Sign In"
            static let toStartPlay = "to start play"
            static let email = "Email"
            static let emailPlaceholder = "Your email"
            static let password = "Password"
            static let passwordPlaceholder = "Your password"
            static let forgotPassword = "Forgot Password?"
            static let orConnectWith = "Or connect with"
            static let orSignUp = "Or Sign Up"
        }

        /// SignUp
        enum SignUp {
            static let title = "Sign Up"
            static let toStartPlay = "to start play"
            static let name = "Name"
            static let namePlaceholder = "Your name"
            static let email = "Email"
            static let emailPlaceholder = "Your email"
            static let password = "Password"
            static let passwordPlaceholder = "Your password"
            static let orSignIn = "Or Sign In"
        }
        
        /// ForgotPassOne
        enum ForgotPassOne {
            static let title = "Forgot Password"
            static let email = "Email"
            static let emailPlaceholder = "Your email"
            static let sent = "Sent"
        }
        
        /// ForgotPassTwo
        enum ForgotPassTwo {
            static let title = "Forgot Password"
            static let password = "Password"
            static let passwordPlaceholder = "Your password"
            static let confirmPassword = "Confirm password"
            static let confirmPasswordPlaceholder = "Your password"
            static let changePassword = "Change password"
        }

        /// Profile
        static let settings = "Settings"
        static let profile = "Profile"
        static let general = "General"
        static let notification = "Notification"
        static let language = "Language"
        static let more = "More"
        static let legalAndPolicies = "Legal And Policies"
        static let aboutUs = "About Us"
        static let logOut = "Log Out"
        static let fullName = "Full Name"
        static let email = "Email"
        static let saveChanges = "Save Changes"
        static let english = "english"
        static let russian = "russian"
        static let enterName = "Enter your full name"
        static let enterEmail = "Enter your Email"
        static let takePhoto = "Take Photo"
        static let choosePhoto = "Choose Photo"
        static let deletePhoto = "Delete Photo"
    }
    
    enum Image {
        /// Profile
        static let stephen = "stephen"
        static let edit = "edit"
        static let globe = "globe"
        static let notification = "notification"
        static let shield = "shield"
        static let information = "information"
        static let arrowLeft = "arrow.left"
        static let editProfileAvatar = "editProfileAvatar"
        static let photoIcon = "camera.shutter.button"
        static let fileIcon = "photo.badge.plus"
        static let noPhoto = "trash"
    }
    
}
