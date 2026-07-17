# Assignment 1: ReactJS Hands-on Lab

This document contains the questions based on the provided PDF labs.

## 1. Office Space Rental App
Create a React Application named `officespacerentalapp`.
- Use JSX to create elements.
- Create an object of office to display details like Name, Rent, Address.
- Loop through the office space items.
- Apply inline CSS: Display the color of the Rent in Red if it's below 60000 and in Green if it's above 60000.

## 2. Cricket App
Create a React Application named `cricketapp`.
- Components: `ListofPlayers`, `IndianPlayers`.
- Use `map()` to display 11 players.
- Use arrow functions to filter players with scores below 70.
- Use destructuring to display odd and even team players.
- Merge `T20players` and `RanjiTrophyPlayers` arrays using ES6 spread operator.

## 3. Counter App
Create a React Application named `counterapp`.
- Component: `CountPeople`.
- Use state to store `entrycount` and `exitcount`.
- `UpdateEntry()` increments entrycount.
- `UpdateExit()` increments exitcount.
- Buttons for Login and Exit.

## 4. Shopping App
Create a React Application named `shoppingapp`.
- Components: `OnlineShopping` and `Cart`.
- `Cart` class has `Itemname` and `Price` as properties.
- `OnlineShopping` class has an array of 5 items.
- Loop through the items and display in a table.

## 5. Trainers App
Create a React Application named `TrainersApp`.
- Implement `react-router-dom` for navigation.
- Components: `Trainer`, `TrainersMock`, `TrainersList`, `Home`, `TrainerDetail`.
- Set up routes for `/` (Home) and `/trainers` (TrainersList).
- Display trainer details using URL parameters (`useParams`).

## 6. Cohort Tracker
Create a React Application named `cohorttracker`.
- Create a CSS module `CohortDetails.module.css`.
- Style a box with width, inline-block, borders, and margins.
- Style `<dt>` and `<h3>` tags using module classes.
- Color the status text based on whether it is "ongoing".

## 7. Score Calculator
Create a React Application named `scorecalculatorapp`.
- Create a function component `CalculateScore`.
- Receive props: `Name`, `School`, `Total`, `goal`.
- Create a CSS stylesheet `mystyle.css`.
- Calculate and display the score percentage.

## 8. Student App
Create a React Application named `StudentApp`.
- Create class components: `Home`, `About`, `Contact`.
- Render all three components sequentially in `App.js`.
- Display a respective welcome message in each component.

## 9. Blog App
Create a React Application named `blogapp`.
- Create class components `Post` and `Posts`.
- Initialize state and implement `componentDidMount()` using Fetch API.
- Fetch posts from JSONPlaceholder.
## 10. Git Client App
Create a React Application named `gitclientapp`.
- Use Axios to fetch repositories for a user from `api.github.com`.
- Write Jest tests mocking `axios` in `GitClient.test.js`.

## 11. Cohort Tracker Tests
- Add Enzyme or RTL tests to the `cohorttracker` app.
- Test that it initializes props, renders HTML properly, and contains the `h3` element.

## 12. Fetch User App
Create a React Application named `fetchuserapp`.
- Fetch data from `https://api.randomuser.me/` and render user details (title, firstname, image).

## 13. Mail Register App
Create a React Application named `mailregisterapp`.
- Implement a form with validations for Name, Email, and Password.

## 14. Ticket Raising App
Create a React Application named `ticketraisingapp`.
- Implement a complaint form that generates a reference number on submit.

## 15. Employees App
Create a React Application named `employeesapp`.
- Convert an app to use React Context API instead of prop-drilling for themes.

## 16. Blogger App
Create a React Application named `bloggerapp`.
- Implement conditional rendering for Book Details, Blog Details, and Course Details.

## 17. Ticket Booking App
Create a React Application named `ticketbookingapp`.
- Implement conditional rendering based on Login/Logout state.

## 18. Event Examples App
Create a React Application named `eventexamplesapp`.
- Implement buttons with synthetic events and event handlers.
- Create a Currency Convertor.

## 19. Git Client App (Duplicate)
- Duplicate of Question 10.
