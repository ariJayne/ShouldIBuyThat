# ShouldIBuyThat

Portrait mode only.

You will be able to enter data about an item you wish to purchase and receive feedback on how many hours you would have to work (either per day up to the date you select) or a total amount of hours (if you select the whenever option when choosing a date). You will then be able to add the input to the priority menu -- it will automatically move the input values to the priority page (second tab) so you won't have to type them twice -- or you can manually navigate to the second tab and put new values in yourself. From there you can change the priority (using the slider) and change any other values if you choose. Exiting the keyboard only requires a tap outside the keyboard, or selecting the return key. Select "add to priority list" to see your input inserted and displayed in a table. Add as many rows to the table as you wish. You can remove a table row by swiping left.

Testing values for validation:

    If you do not fill out all fields, and try to click the "find out" button from the home tab or "add to list button" from the priority tab, you will receive an error message.
    if you do not open the date picker,-- the button that says "when do you want it?" -- and try to select the button below for feedback-- applies to both tab views-- you will get an error message.
        there is one caveat where you only need to open the date picker once-- from there the date value is stored until you choose another option-- and it will only close if you do not select one of the two buttons. If you select done without choosing a date, it will default to the one on the screen.
    the keyboards should only allow you to type in proper values for each input textfield-- like decimal for your rate of pay and cost of the item. I'm not sure if it sets the keyboard properly on ipads--but this app is mainly meant for iphones.
    type in values where the cost of the item is very high, and your rate of pay is very low, then a date where it would be impossible to make enough hours in time-- this will display another error message
