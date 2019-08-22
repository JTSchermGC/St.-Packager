public class JSON2Apex {
	
	public Result result {get;set;} 
	public JSON2Apex(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'result') {
						result = new Result(parser);
                        //system.debug(result);
					} else {
						//System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Payment_start_date {
		public String lessThanTodayDate {get;set;} 

		public Payment_start_date(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'lessThanTodayDate') {
							lessThanTodayDate = parser.getText();
						} else {
							//System.debug(LoggingLevel.WARN, 'Payment_start_date consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Donor_payment_method_id {
		public String invalidPaymentMethod {get;set;} 

		public Donor_payment_method_id(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'invalidPaymentMethod') {
							invalidPaymentMethod = parser.getText();
						} else {
							//System.debug(LoggingLevel.WARN, 'Donor_payment_method_id consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Validation_messages {
		public Payment_start_date payment_start_date {get;set;} 
		public Donor_payment_method_id donor_payment_method_id {get;set;} 

		public Validation_messages(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'payment_start_date') {
							payment_start_date = new Payment_start_date(parser);
						} else if (text == 'donor_payment_method_id') {
							donor_payment_method_id = new Donor_payment_method_id(parser);
						} else {
							//System.debug(LoggingLevel.WARN, 'Validation_messages consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Detail {
		public Validation_messages validation_messages {get;set;} 

		public Detail(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'validation_messages') {
							validation_messages = new Validation_messages(parser);
						} else {
							//System.debug(LoggingLevel.WARN, 'Detail consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Result {
		public String type_Z {get;set;} // in json: type
		public String title {get;set;} 
		public Integer status {get;set;} 
		public String key {get;set;} 
		public Detail detail {get;set;} 

		public Result(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'type') {
							type_Z = parser.getText();
						} else if (text == 'title') {
							title = parser.getText();
						} else if (text == 'status') {
							status = parser.getIntegerValue();
						} else if (text == 'key') {
							key = parser.getText();
						} else if (text == 'detail') {
							detail = new Detail(parser);
						} else {
							//System.debug(LoggingLevel.WARN, 'Result consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static JSON2Apex parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSON2Apex(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	

}