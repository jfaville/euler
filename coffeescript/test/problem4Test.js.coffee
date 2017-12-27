require 'coffee-script/register'
chai = require 'chai'
chai.should()

{Palindrome, Maximum, Problem4} = require '../src/problem4'

describe 'Palindrome instance', ->
    palindrome1 = null
    it 'should have a private value accessible by get', ->
        palindrome1 = new Palindrome "abba"
        palindrome1.get().should.equal "abba"
    it 'should have a private value changeable by set', ->
        palindrome1.set("baab")
        palindrome1.get().should.equal "baab"
    it 'should throw an error when set to a non-palindrome', ->
        (-> palindrome1.set("abab")).should.throw Error, "abab must be a palindrome."
        palindrome1.get().should.equal "baab"
    it 'should have a check method accessible from outside the class', ->
        Palindrome.check("abba").should.equal true
        Palindrome.check("abab").should.equal false
    it 'should also work for numbers', ->
        Palindrome.check(121).should.equal true
        Palindrome.check(122).should.equal false
        
describe 'Maximum instance', ->
    maximum1 = null
    maximum2 = null
    class Foo
        constructor: (@value) ->
        valueOf: -> @value
    it 'should be instantiated with a class and initial value of zero by default', ->
        maximum1 = new Maximum Palindrome
        maximum1._class.should.equal Palindrome
        maximum1._value.should.equal 0
    it 'should have a private value accessible by get', ->
        maximum1.get().should.equal 0
    it 'should have a private value changeable by set', ->
        maximum1.set(55)
        maximum1.get().should.equal 55
    it 'should throw an error when set to a value less than its current one', ->
        (-> maximum1.set(44)).should.throw RangeError, "44 must be at least 55."
        maximum1.get().should.equal 55
    it 'should throw an error when set to a value which fails a Class.check method', ->
        (-> maximum1.set(68)).should.throw TypeError, "68 must be a Palindrome."
        maximum1.get().should.equal 55
    it 'should throw an error when set to a value not an instance of a checkless class', ->
        maximum2 = new Maximum Foo, new Foo(5)
        (-> maximum2.set(6)).should.throw TypeError, "6 must be a Foo."
        