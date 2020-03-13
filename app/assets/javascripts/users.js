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
    //prevent default submission behaviour, changing and graying-out the btn
    event.preventDefault(); 
    submitBtn.val("Processing").prop('disabled', true);
    
    //Collect CC fields, assigning them all in one statement
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(), 
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
        
    //Use Stripe js library to check for card errors
    var error = false;
    
    //Validate CC number
    if (!Stripe.card.validateCardNumber(ccNum)){
      error = true;
      alert('The credit card number appears to be invalid')
    }
    //Validate CVC code
    if (!Stripe.card.validateCVC(cvcNum)){
      error = true;
      alert('The CVC number appears to be invalid')
    }
    //Validate expiration date
    if (!Stripe.card.validateExpiry(expMonth, expYear)){
      error = true;
      alert('The expiration date appears to be invalid')
    }
    
    if (error){
      //If there are card errors, don't send to Stripe 
      submitBtn.val("Sign Up").prop('disabled', false);
    } else {
      //Send CC information to Stripe
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_Month: expMonth,
        exp_Year: expYear
      }, stripeResponseHandler);
    }
    return false;
  }); 
  
  //Stripe will return a card token
  function stripeResponseHandler(status, response){
    //Get the token from the response
    var token = response.id;
    //Inject card token as hidden field into form
    theForm.append($ ('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    //Submit form to Rails app
    theForm.get(0).submit();
  }
  
});