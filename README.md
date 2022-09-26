# Shopping App

### Deadline

We'll be waiting for your solution within 5 days. 

### Submission:

After completing the assignment, create a pull request to `main` branch.
Then please send an email to the People Department with the link of the GitHub repo.

### Before Starting

Do not create any other private/public repositories other than this. You must perform all your development on this repository. 

### Goal ###

Develop a simple shopping app that allows the user to display products from the mock api response in a list and add/remove any of them to/from the cart. 

### Technical Requirements:

* Use Swift.
* Feel free to use any architecture or design pattern.
* Do not use any reactive paradigm (SwiftUI, RxSwift etc.)
* UserDefaults or Singleton concepts could also be used for local storage on basket page.
* You can build the user interface with XIBs || Storyboards || Code
* Do not use any 3rd party libraries(other than Realm).

### Functional Requirements ###

* App must contain at least 3 different main features, including Product Listing, Product Detail, Shopping Cart.

* Main Screen
  * App must fetch and display the data from given mock API and it should be persisted locally.
  * Persisted data and item counts should remain until successful checkout action.
  * Users must be able to click product items in the list and route to "Details" screen.
  * If the user have any product in the cart, the total amount should be displayed on the screen correctly.
  * User must be able to route to the "Cart" Screen from "Main" screen, by clicking a button etc.
  * After returning back from Details screen, all the changes made must be displayed correctly.

* Details Screen
  * The product's detailed image, name, price, description and current amount in the cart should be displayed correctly.
  * User must be able to update the amount of the products in the cart and save it by clicking "Update Cart" button or a different approach, It's up to you.

* Shopping Cart Screen
  * User must be able to see all the items and individual counts in the cart as listed correctly.
  * When user click's the "Checkout" button, a meaningful success message must be displayed at the screen.
  * The success message must contain the total cart amount and display it correctly.
  * After checkout action, all the local data should be reset (item counts in the cart must be zero)
  * If any product item's count is zero, the item must not be displayed in the cart list
  * User must not be able to route to the Cart Screen, if there is no item in the shopping cart.

### Mock API Url ###

https://mocki.io/v1/6bb59bbc-e757-4e71-9267-2fee84658ff2

### UI Suggestions ###

It doesn't need to be super pretty, but it shouldn't be broken as well. The design is mostly up to you as long as all the features are available to use. You can follow or be inspired by the mock design below, it's up to you. 

![UI Mock](https://github.com/ios-getir/ShoppingApp/blob/main/screenshots/img_screenshot.png)

### Expectations ###

Consider this as a showcase of your skills.
Approach it as if you are going to make a pull request on our main/master branch.

We are expecting at least:
* Project is compatible to Xcode 13.2.x
* The code must compile.
* The code must be production ready.
* Keep code as clean as possible.
* Your code should be easy to maintain
* Do not try to build a fancy UI, your implementation details are more important
* Consistency on code convention and indentation
* Git usage.
* A README.md which describes technical details/decisions

Nice to have (Bonus Points):
* At least one custom view
* Tests (Unit | UI)
* Modular Approach
