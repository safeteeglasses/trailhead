@isTest
private with sharing class CalculatorTests {
    
    @isTest
    static void testDivideByZero() {
        try{
            Test.startTest();
            Integer num = 2;
            Integer denom = 0;  
            Calculator.divide(num, denom);
            Test.stopTest();
            Assert.fail('An Exception should be thrown here');
        } catch (Calculator.CalculatorException e) {
            Assert.isTrue(
            e.getMessage().equalsIgnoreCase('You still can\'t divide by zero'),
            'Exception message does not match: ' + e.getMessage());
        }
    }
    
    @isTest
    static void returnNegativeNumberTest(){
        Decimal returnValue;
        try {
            Test.startTest();
            returnValue = Calculator.divide(-8, 2);
            Test.stopTest();
            Assert.fail('An Exception should be thrown here');
        } catch (Calculator.CalculatorException e) {
            Assert.isTrue(e.getMessage().equalsIgnoreCase('Division returned a negative value.' + returnValue),
            'Exception message does not match: ' + e.getMessage());
        }
    } 
    
    @isTest
    static void multiplyByZero(){
        try {
            Test.startTest();
            Integer num1 = 2;
            Integer num2 = 0;
            Calculator.multiply(num1, num2);
            Test.stopTest();
            Assert.fail('We should throw an exception here');
        } catch (Calculator.CalculatorException e) {
            Assert.isTrue(e.getMessage().equalsIgnoreCase('It doesn\'t make sense to multiply by zero'));
        }
    }
    
    @isTest 
    static void multiplyTwoPositiveNumbers(){
        Test.startTest();
        Integer result = Calculator.multiply(5, 2);
        Test.stopTest();
        Assert.areEqual(10, result, 'Expected the result 10');
    }
    
    @isTest
    static void testSubtraction(){
        Test.startTest();
        Integer result = Calculator.substract(5, 2);
        Test.stopTest();
        Assert.areEqual(3, result, 'Expected result of 3');
    } 
    
    @isTest 
    static void testAddition(){
        Test.startTest();
        Integer result = Calculator.add(10, 5);
        Test.stopTest();
        Assert.areEqual(15, result, 'Expected result of 15');
    }
}