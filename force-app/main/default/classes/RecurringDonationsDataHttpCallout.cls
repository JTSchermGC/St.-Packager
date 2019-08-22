@Istest 
global class RecurringDonationsDataHttpCallout implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest req) {

        HttpResponse respost = new HttpResponse();
        respost.setHeader('Content-Type', 'application/json');

        String endPoint = String.valueOf(req.getEndpoint());
        if(endPoint.contains(Label.NewRecurringApi))  
        {   
          	respost.setBody('{"donor_events_id":"14164","gcid":"1308004","userid":"XQbTEfD224546","event_id":"15281","event_title":"sort2","event_start_date":"2019-02-14","event_end_date":"2020-06-30","restrict_donations_beyond_end_date":"0","memo":"","eventFrequency":["One-Time","Weekly","Bi-Weekly","Monthly","Quarterly","Semi-Annually","Annually"],"minimumAmount":["0","0","0","0","0","0","0"],"databasePledgeId":"","event_type":"Pledge Events","EventBanner":"","pledge_amount":"20.00","amount":"4.00","card_number":"xxx1111","payment_frequency":"Weekly","payment_start_date":"2019-02-27","payment_end_date":"2019-03-27","neverEndDate":"0","source_code":"110011","parish_id":"10","location_id":"1","location_name":"GiveCentral\u0026#39;s","processedSchedules":[{"DonorEventsId":"14164","DonorPaymentScheduleId":"292749","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-02-27","Status":"declined","ResponseStatus":"","TransactionId":"C5C76882E47845","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"}],"schedules":[{"DonorEventsId":"14164","DonorPaymentScheduleId":"292750","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-03-06","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"},{"DonorEventsId":"14164","DonorPaymentScheduleId":"292751","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-03-13","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"},{"DonorEventsId":"14164","DonorPaymentScheduleId":"292752","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-03-20","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"},{"DonorEventsId":"14164","DonorPaymentScheduleId":"292753","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-03-27","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"}]}');
        }
        else if(endPoint.contains(Label.SFDCGePatchRecord))  
        {   
          	respost.setBody('{"donor_events_id":"14164","gcid":"1308004","userid":"XQbTEfD224546","event_id":"15281","event_title":"sort2","event_start_date":"2019-02-14","event_end_date":"2020-06-30","restrict_donations_beyond_end_date":"0","memo":"","eventFrequency":["One-Time","Weekly","Bi-Weekly","Monthly","Quarterly","Semi-Annually","Annually"],"minimumAmount":["0","0","0","0","0","0","0"],"databasePledgeId":"","event_type":"Pledge Events","EventBanner":"","pledge_amount":"20.00","amount":"4.00","card_number":"xxx1111","payment_frequency":"Weekly","payment_start_date":"2019-02-27","payment_end_date":"2019-03-27","neverEndDate":"0","source_code":"110011","parish_id":"10","location_id":"1","location_name":"GiveCentral\u0026#39;s","processedSchedules":[{"DonorEventsId":"14164","DonorPaymentScheduleId":"292749","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-02-27","Status":"declined","ResponseStatus":"","TransactionId":"C5C76882E47845","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"}],"schedules":[{"DonorEventsId":"14164","DonorPaymentScheduleId":"292750","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-03-06","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"},{"DonorEventsId":"14164","DonorPaymentScheduleId":"292751","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-03-13","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"},{"DonorEventsId":"14164","DonorPaymentScheduleId":"292752","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-03-20","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"},{"DonorEventsId":"14164","DonorPaymentScheduleId":"292753","DonorPaymentMethodId":"11761","Amount":"4.00","TransactionDate":"2019-03-27","payment_method":"Visa-xxx1111","payment_method_type":"Credit Card"}]}');
        }
        else if(endPoint.contains(Label.client_token_url))
        { 
            respost.setBody('{"access_token":"17261f623da5e3abf5ebd1275d94821e29258172","expires_in":18000,"token_type":"Bearer","scope":null,"refresh_token":"329d208b26e1900d47d418a27a06903c42ecbb54"}');
            
        }
          respost.setStatusCode(201);
        return respost;
    }
}