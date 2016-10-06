//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
    var DataStructure: [String] = ["0","0", "0", "0"]
    //DataStructure is a list of strings
    
    
    //counter will track which part of the Data Structure I am on
    var counter = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateSomeDataStructure(_ content: String) {
        //print("Update me like one of those PCs")
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        //resultLabel.text = "67"
       // print(content)
        self.resultLabel.text = content
        //print("Update me like one of those PCs")
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        return "0"
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        print("Calculation requested for \(a) \(operation) \(b)")
        var result = 0
        if (operation == "+") {
            result = a + b
        } else if (operation == "-") {
            result = a - b
        }else if (operation == "/") {
            result = a/b
        } else if (operation == "*") {
            result = a * b
        }
        
        return result
    }
    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        print("Calculation requested for \(a) \(operation) \(b)")
        print("goes to double calculation")
        //convert a and b to intergers
        let arg1 = Double(a)!
        let arg2 = Double(b)!
        var result = 0.0
        if (operation == "+") {
            result = arg1 + arg2
        } else if (operation == "-") {
            result = arg1 - arg2
        }else if (operation == "/") {
            result = arg1/arg2
        } else if (operation == "*") {
            result = arg1 * arg2
        }
        return result
    }
    var user_num = "0"
    var latest_operator = ""
   
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        print("The number \(sender.content) was pressed")
        print("counter1 \(counter)" )

        DataStructure[counter] = latest_operator
        if operator_pressed {
            counter += 1
            operator_pressed = false
        }
        if (user_num == "0") {
            user_num = sender.content
            updateResultLabel(user_num)
        } else {
            if (user_num.characters.count < 7) {
                user_num += sender.content
                updateResultLabel(user_num)
            }
        }
        //build up the number that user inputs
        number_pressed = true
    }
    var decimal_pressed = false
    var number_pressed = false
    var operator_pressed = false
    var gotResult = false

    
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        decimal_pressed = false
        // Fill me in!
        print("The operator \(sender.content) was pressed")
        
        if (sender.content == "C") {
            user_num = "0"
            updateResultLabel("0")
            DataStructure = ["0", "0","0","0"]
            number_pressed = false
            counter = 0
            gotResult = false
            operator_pressed = false
        }
        //only add the negative in front of the number once
        if (operator_pressed) {
            latest_operator = sender.content
        }
        if (sender.content == "+/-") {
            var value  = Int(user_num)
            value = 0 - value!
            user_num = String(value!)
            updateResultLabel(user_num)
        } else if number_pressed {
            number_pressed = false
            DataStructure[counter] = user_num
            print(user_num)
            if counter == 2 {
                let arg1 = Int(DataStructure[0])
                let arg2 = Int(DataStructure[2])
                let op = DataStructure[1]
                var result = 0
                var result2 = 0.0
                //determine if the calculation should be done in double or int
                //if the strings have a . then double.
                //if doesn't have it but the mod of it is not 0 use double
                if (DataStructure[0].contains(".") == false) && (DataStructure[2].contains(".") == false) {
                    //both doesn't have . 
                    //check the mod
                    if (op == "/" && arg1! % arg2! == 0) {
                        //if int calculation
                        result = intCalculate(a: arg1!, b: arg2!, operation: op)
                        DataStructure[0] = String(result)
                        updateResultLabel(String(result))
                    } else if(op == "/") {
                        result2 = calculate(a: DataStructure[0], b: DataStructure[2], operation: op)
                        DataStructure[0] = String(result2)
                        updateResultLabel(String(result2))
                    } else {
                        result = intCalculate(a: arg1!, b: arg2!, operation: op)
                        DataStructure[0] = String(result)
                        updateResultLabel(String(result))
                    }
                } else {
                    //if double calculation
                    result2 = calculate(a: DataStructure[0], b: DataStructure[2], operation: op)
                    DataStructure[0] = String(result2)
                    updateResultLabel(String(result2))
                }
                counter = 0
                gotResult = true
            }
            counter += 1
            latest_operator = sender.content
            user_num = ""
            operator_pressed = true
        } else if gotResult == true && operator_pressed {
            latest_operator = sender.content
        }
    }
    //after pressing equals can either press an operator again or a number
    
    
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
        DataStructure[counter] = latest_operator
        number_pressed = true
        // 0 and .
        print(sender.content)
        if operator_pressed {
            counter += 1
            operator_pressed = false
        }
        
        
        //if user_num == "" and . was pressed for the first time
        
        //if decimal is the first input pressed
        if user_num == "0" && sender.content == "." && decimal_pressed == false {
            user_num = user_num + "."
            updateResultLabel(user_num)
            decimal_pressed = true
        }
        //prevents 0 from being inputted multiple times in the front
        else if sender.content == "0" && user_num == "0" {
            updateResultLabel(user_num)
        } else if sender.content == "0" && user_num != "0" {
            user_num += sender.content
            updateResultLabel(user_num)
        } else if (decimal_pressed == false && sender.content == "."){
            //prevents the user from clicking the . too many times
            user_num += sender.content
            updateResultLabel(user_num)
            decimal_pressed = true
            
        }
        number_pressed = true
        
       // Fill me in!
    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}

