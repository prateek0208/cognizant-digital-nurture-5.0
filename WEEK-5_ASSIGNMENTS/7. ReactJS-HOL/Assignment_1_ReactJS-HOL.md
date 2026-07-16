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
- Implement `componentDidCatch()` for error handling.
