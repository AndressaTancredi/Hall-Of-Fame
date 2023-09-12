# DIGITAL HALL OF FAME

Designed for a large-scale event company operating in the southern region of Brazil, this project involves the creation of a specialized Android application intended for deployment on a 24-inch kiosk. The application offers a comprehensive solution for tourists visiting the region. Tourists can register with the company and access the kiosk using their pre-registered CPF (Brazilian identification number).

The application interfaces with an API to validate the tourist's registration status. If the tourist is registered, the application seamlessly transitions to a hand-scanning interface. This interface emulates a real scanner, generating randomized hand images for a realistic scanning experience. After the scanning process, tourists can digitally sign their names using the kiosk's touchscreen interface. Upon confirmation of the signature, the application transforms the text into an image, merging it with the scanned hand image to create a promotional template for the company. This template showcases the customer's hands immortalized on a digital "Hall of Fame."

In the subsequent screen, tourists can easily share this image on their social media platforms via a QR code. To facilitate this, the application sends a POST request to the company's API with customer data (retrieved via a prior GET request using the CPF, which is stored during the registration verification process). The POST request returns an image URL, which serves as the QR code for sharing. After a brief interval, the screen automatically returns to the initial interface.



https://github.com/AndressaTancredi/Hall-Of-Fame/assets/48730376/af1e1fc4-2694-435a-8ebf-1ef08ffece56



## Contents

- [Overview](#overview)
- [Features](#features)
- [Tech MVP](#tech-mvp)
- [Project Evolution](#project-evolution)

## Overview

An application developed for a large event company operating in the southern region of Brazil. The project allows tourists to register with the company and access a 24-inch Android kiosk using their pre-registered CPF (Brazilian identification number). The application verifies the registration via an API and, if approved, enables tourists to use the hand scanner to create a promotional image with their hands on the company's digital "Walk of Fame." They can share this image on their social media through a QR code.

## Features

- Tourist registration with the event company.
- Registration validation via API.
- Simulation of a hand scanner.
- Digital signature capture.
- Creation of a promotional image combining the signature and scanned hand image.
- Sharing of the image on social media through a QR code.
- Integration with an API to obtain the QR code.

## Tech MVP

- **get_it:** To facilitate dependency injection, we employ GetIt for efficient and flexible management of service instances across the app.
- **scanning_effect:** For an engaging user experience, we implement the `scanning_effect` package to simulate a hand-scanning effect, creating a visually immersive interaction.
- **signature:** To capture digital signatures, we incorporate the `signature` package, enabling users to sign their names directly on the device's touchscreen.
- **share:** We use the `share` package to empower users to effortlessly share their personalized digital "Walk of Fame" images on their preferred social media platforms.
- **path_provider:** With `path_provider`, we gain access to the device's file system, allowing us to efficiently store and manage image files generated during the app's operation.
- **provider:** To facilitate state management, we adopt the `provider` package, enabling seamless data sharing and updates across various components of our application.
- **http:** We employ the `http` package to interact with external APIs, ensuring secure and efficient communication for user registration and QR code retrieval.
- **qr_flutter:** For generating QR codes, we integrate the `qr_flutter` package, providing users with a convenient means to share their digital masterpieces via QR codes.

These packages collectively enhance the functionality and interactivity of our application, creating a seamless and enjoyable experience for tourists visiting the southern region of Brazil.

## Project Evolution

This README describes the initial Minimum Viable Product (MVP) of our project, created to validate its feasibility and basic functionalities. Since then, we have made significant progress in terms of development and enhancement.

Currently, the application boasts a robust architecture based on the MVVM (Model-View-ViewModel) pattern, promoting clear separation of concerns, making it highly scalable and maintainable. State management is efficiently handled through Bloc, providing a smoother and more responsive user experience. Furthermore, we have implemented rigorous testing to ensure the stability and reliability of the application in various scenarios.

These improvements signify our ongoing commitment to the quality and evolution of this project, and we look forward to sharing future updates and features with our user community.

Made with ❤ by Andressa Tancredi.

