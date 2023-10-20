import HelloApp.*;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextPackage.*;
import org.omg.CORBA.*;
import org.omg.PortableServer.*;
import org.omg.PortableServer.POA;

import java.util.Map;
import java.util.Properties;

class HelloImpl extends HelloPOA {
  private ORB orb;

  public void setORB(ORB orb_val) {
    orb = orb_val; 
  }
    
  // implement sayHello() method
  public String sayHello() {
    return "\nHello world !!\n";
  }

@Override
public String showMenu() {
	String menu = " Cola : $1 \n Fried Chicken : $5 ";
    return menu;
}

@Override
public String placeOrder(String username, int chickenCount, int colaCount) {
	// TODO Auto-generated method stub
	if( GlobalHashMap.orderDetails.containsKey(username) ){
        return "One order already present";
    }else{
        OrderDetails newOrder = new OrderDetails();
        newOrder.setCount(chickenCount, colaCount);
        GlobalHashMap.orderDetails.put(username.trim().toLowerCase(), newOrder);
        return "New order created. Your total is"+newOrder.getTotal();
    }
}

@Override
public String getOrderStatus(String username) {
	if(GlobalHashMap.orderDetails.containsKey(username.trim().toLowerCase())){
        OrderDetails existingOrder = GlobalHashMap.orderDetails.get(username);
        return "you have ordered : \n Chicken :"+existingOrder.getFCCount()+"\nCola : "+existingOrder.getColaCount()+"\n total is "+existingOrder.getTotal();
    }
    return "You have no orders";
}

@Override
public String allCurrentOrders(String username) {
	// TODO Auto-generated method stub
	String resultVal = "";
    if(username.trim().toLowerCase().compareTo("manager") == 0){
        for(Map.Entry<String, OrderDetails> entry : GlobalHashMap.orderDetails.entrySet()){
            resultVal += "User: "+  entry.getKey() +" has ordered: fried chicken: "+entry.getValue().getFCCount()+" Cola:"+entry.getValue().getColaCount()+" and total is:"+entry.getValue().getTotal()+"\n";
        }
        if(resultVal.length() == 0){
            resultVal = "No orders available";
        }
    }
    return resultVal;
}
    
  // implement shutdown() method
  // public void shutdown() {
  //   orb.shutdown(false);
  // }
}


public class HelloServer {

  public static void main(String args[]) {
    try{
      // create and initialize the ORB
      ORB orb = ORB.init(args, null);

      // get reference to rootpoa & activate the POAManager
      POA rootpoa = POAHelper.narrow(orb.resolve_initial_references("RootPOA"));
      rootpoa.the_POAManager().activate();

      // create servant and register it with the ORB
      HelloImpl helloImpl = new HelloImpl();
      helloImpl.setORB(orb); 

      // get object reference from the servant
      org.omg.CORBA.Object ref = rootpoa.servant_to_reference(helloImpl);
      Hello href = HelloHelper.narrow(ref);
          
      // get the root naming context
      // NameService invokes the name service
      org.omg.CORBA.Object objRef =
          orb.resolve_initial_references("NameService");
      // Use NamingContextExt which is part of the Interoperable
      // Naming Service (INS) specification.
      NamingContextExt ncRef = NamingContextExtHelper.narrow(objRef);

      // bind the Object Reference in Naming
      String name = "Hello";
      NameComponent path[] = ncRef.to_name( name );
      ncRef.rebind(path, href);

      System.out.println("HelloServer ready and waiting ...\n");

      // wait for invocations from clients
      orb.run();
    } 
        
      catch (Exception e) {
        System.err.println("ERROR: " + e);
        e.printStackTrace(System.out);
      }
          
      System.out.println("HelloServer Exiting ...");
        
  }
}