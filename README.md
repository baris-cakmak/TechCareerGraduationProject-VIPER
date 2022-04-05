<h1 
align="center">
<br>
  <img src="https://user-images.githubusercontent.com/96867747/161801313-caa2dbfd-35ff-4c05-8293-935d21511bfb.jpg" width="100">
<br>
<br>
TechCareerGraduationProject-VIPER </h1>

<h5 align="left"> 
<br>
Techcareer is a brand under the one of the biggest hiring company that is called kariyer.net in Turkey which is focused on technology and bootcamps.

</h5>

<h5 align="left"> During the Development, most of the time VIPER rules are considered for the clean code purposes.
</h5>
<br>



## Screenshots
<p float="left">
  <img src="https://user-images.githubusercontent.com/96867747/161714293-711b8229-18f7-44f3-a4e0-ec074560a4db.png" width="200" />
  <img src="https://user-images.githubusercontent.com/96867747/161714289-5b37ddbe-a655-4495-86b9-4a11cecbd956.png" width="200" />
  <img src="https://user-images.githubusercontent.com/96867747/161725478-8ee26b41-ccb0-4e35-b1fc-1e903d60d176.png" width="200" /> 
  <img src="https://user-images.githubusercontent.com/96867747/161724952-f9f1fcb4-56de-4445-aab5-c5d4d2235aa1.png" width="200" /> 
</p>


## Project Requirements

- Given all API endpoints by the instructor must be used in the project
- Users must add products to the cart
- Users must delete a single item

## Architecture
VIPER. I have used ViewModels in Presenter Layer and Router handles all of the navigation(Views have no navigation-related code). This is why some of the Router layers interact with the Presenter.

## Tech stack & Open-source libraries 
- Onboarding, log in and Authenticated User scenarios are considered and each scenario is handled by the RootModule to show the first Module/View
- iOS 13+ available [UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)  (The whole project is done by compositional layout since there is no need for nested collection views and it has advantages over Flow layout)
- iOS 14+ available new [PageControlAPI](https://developer.apple.com/documentation/uikit/uipagecontrol/3577679-preferredindicatorimage) (preferredIndicatorImage and continous interaction) is used in Onboarding Screen for better UI performance
- [Moya](https://github.com/Moya/Moya) for Network Abstraction (I have created a dummy API that differs from the instructor's API and abstracting each Target via Moya is powerful and fast. Check the Enterprise folder in the project.. Also, it uses Alamofire as a backbone)
- Restaurant Endpoint is configured by me which you can look at the JSON file in my repo via [link](https://github.com/baris-cakmak/dummy-restaurant-api)
- [Lottie](https://github.com/airbnb/lottie-android) Lottie is a powerful library for animations and every screen has Lottie animation for better UI Performance. Big thanks to Airbnb team
- [FirebaseAuth](https://github.com/firebase/firebase-ios-sdk) to user authenticate, FirebaseAuth is used for log in and Register
- [FirebaseFirestore](https://github.com/firebase/firebase-ios-sdk) to save user information such as profile image URL and so on, FirebaseFirestore is used. RealtimeDatabase could have been used as well.
- [FirebaseStorage](https://github.com/firebase/firebase-ios-sdk) to save the user's profile image on a Cloud to fetch and display on Profile Screen
- [SDWebImage](https://github.com/SDWebImage/SDWebImage) to handle all of the images in a network, SDWebImage is used. Also, iOS 13+ Available large indicator loading is used for better UX performance

https://user-images.githubusercontent.com/96867747/161802138-2b68f4b6-10dd-4a40-9d8e-29f80d227091.mp4

