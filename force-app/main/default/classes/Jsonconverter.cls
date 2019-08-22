public class Jsonconverter {
	public Result result;
    
	public class Result{
        public String type;
     	public String title;
     	public String status;
     	public String key;
        public detail detail;
    }     
  
    public class detail{
        public validation_messages validation_messages;
    }
    public class validation_messages{
        public donor_payment_method_id donor_payment_method_id;
        public accountsMerchantId accountsMerchantId;
    }
	
    public class donor_payment_method_id{
    	public String digit;
    }
    
    public class accountsMerchantId{
    	public String invalidMerchantId;
    }
    

    public static Jsonconverter parse(String json) {
      return (Jsonconverter) System.JSON.deserialize(json, Jsonconverter.class);
    }
    
}