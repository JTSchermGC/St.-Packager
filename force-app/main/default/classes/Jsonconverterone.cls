public class Jsonconverterone {
    
    public String type;
    public String title;
    public String status;
    public String key;
	public Detail detail;
    
    public class Detail{
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
    

    public static Jsonconverterone parse(String json) {
      return (Jsonconverterone) System.JSON.deserialize(json, Jsonconverterone.class);
    }
}