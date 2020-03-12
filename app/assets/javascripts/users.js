/* global $, Stripe */
//Document ready
$(document).on('turbolinks:load', function(){
  
  //Target the form and its Submit button with CSS selectors
  var theForm = $('#pro_form');
  var submitBtn = $('#form-signup-btn');
  
  //Set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  //When user clicks form Submit button,
  submitBtn.click(function(event){
    //prevent default submission behaviour
    event.preventDefault(); 
    
    //Collect CC fields, assigning them all in one statement
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    //Send CC information to Stripe
    Stripe.createToken({
      number: ccNum,
      cvc: cvcNum,
      exp_Month: expMonth,
      exp_Year: expYear
    }, stripeResponseHandler);
  }); 
  
  //Stripe will return a card token
  //Inject card token as hidden field into form
  //Submit form to Rails app
});