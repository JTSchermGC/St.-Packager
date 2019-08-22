trigger UpdateIdStatus on Opportunity (after insert,after update) {
	/*List<Account> accountsWithContacts = [select id, name, (select id, salutation, descriptio,
   firstname, lastname, email from Contacts)
   from Account where Id IN :Trigger.newMap.keySet()];
 
 
   List<Contact> contactsToUpdate = new List<Contact>();
 
   for(Account a: accountsWithContacts){
      // Use the child relationships dot syntax to access the related Contacts
      for(Contact c: a.Contacts){
 
         c.Description=c.salutation + ' ' + c.firstName + ' ' + c.lastname;
 
         contactsToUpdate.add(c);
 
      }
   }
   //Now outside the FOR Loop, perform a single Update DML statement.
   update contactsToUpdate;
*/
}