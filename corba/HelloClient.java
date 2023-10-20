import HelloApp.*;
import org.omg.CosNaming.*;
import org.omg.CosNaming.NamingContextPackage.*;

import java.io.*;

import org.omg.CORBA.*;

public class HelloClient {
	static Hello helloImpl;

	public static void main(String args[]) {
		try {
			// create and initialize the ORB
			ORB orb = ORB.init(args, null);

			// get the root naming context
			org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");
			// Use NamingContextExt instead of NamingContext. This is
			// part of the Interoperable naming Service.
			NamingContextExt ncRef = NamingContextExtHelper.narrow(objRef);

			// resolve the Object Reference in Naming
			String name = "Hello";
			helloImpl = HelloHelper.narrow(ncRef.resolve_str(name));

			System.out.println("Obtained a handle on server object: " + helloImpl);
			System.out.println(helloImpl.sayHello());
			// helloImpl.shutdown();
			int userInput = -1;
			do {
				try {
					System.out.println("If you are customer, Please press 1. \nIf you are manager, Please press 2.");
					userInput = getNumInput();
					if (userInput == 1) {
						customerOptions();
					} else if (userInput == 2) {
						managerOptions();
					} else {
						System.out.println("Select correct option");
					}
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println("Please try again with other options.");
				}
				
			} while (userInput != 0);
		} catch (Exception e) {
			System.out.println("ERROR : " + e);
			e.printStackTrace(System.out);
		}
	}

	public static int getNumInput() throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String s = br.readLine();
		int choice = -1;
		try {
			choice = Integer.valueOf(s);
		} catch (NumberFormatException e) {
			System.out.println("Input is not a number. Try again.");
			return choice;
		}
		if (choice < 0) {
			System.out.println("Negative input. Try again.");
			choice = -1;
		}
		return choice;
	}

	public static String getStringInput() throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String s = br.readLine();
		return s;
	}

	public static void customerOptions() throws IOException {
		int userInput = -1;
		do {
			System.out.println(
					"Press 1 for Menu.\nPress 2 for Placing order \nPress 3 for order status \nPress 4 to go back.");
			System.out.println("select your options");
			userInput = getNumInput();

			switch (userInput) {
			case 1:
				String menu = helloImpl.showMenu();
				System.out.println(menu);
				break;
			case 2:
				System.out.println("What is your name?");
				String username = getStringInput();
				System.out.println("How many chicken do you want?");
				int cickenCount = getNumInput();
				System.out.println("How many cola do you want?");
				int colaCount = getNumInput();
				String order = helloImpl.placeOrder(username, cickenCount, colaCount);
				System.out.println(order);
				break;
			case 3:
				System.out.println("What is your name?");
				String currentUser = getStringInput();
				String orderStatus = helloImpl.getOrderStatus(currentUser);
				System.out.println(orderStatus);
				break;
			case 4:
				System.out.println("Going back to the main menu.");
				break;
			default:
				break;
			}
		} while (userInput != 4);
		return;
		
	}

	public static void managerOptions() throws IOException {
		int userInput = -1;
		do {
			System.out.println("Select 1 to view all orders. /nSelect 2 to go back.");
			System.out.println("select your options");
			userInput = getNumInput();
			switch (userInput) {
			case 1:
				System.out.println("What is your name?");
				String currentUser = getStringInput();
				String allOrders = helloImpl.allCurrentOrders(currentUser);
				System.out.println(allOrders);
				break;
			case 2:
				System.out.println("Going back to the main menu.");
				break;
			default:
				break;
			}
		} while (userInput != 2);
		return;
	}
}
