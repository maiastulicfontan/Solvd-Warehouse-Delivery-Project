package com.solvd.warehouseProject;

import java.time.LocalDate;

import com.solvd.warehouseProject.exceptions.OrderVolumeExceededException;
import com.solvd.warehouseProject.models.Company;
import com.solvd.warehouseProject.models.Country;
import com.solvd.warehouseProject.models.Order;
import com.solvd.warehouseProject.models.OrderDetail;
import com.solvd.warehouseProject.models.Product;
import com.solvd.warehouseProject.models.ProductCategory;
import com.solvd.warehouseProject.models.Truck;
import com.solvd.warehouseProject.models.Warehouse;
import com.solvd.warehouseProject.services.CompanyService;
import com.solvd.warehouseProject.services.CountryService;
import com.solvd.warehouseProject.services.OrderDetailService;
import com.solvd.warehouseProject.services.OrderService;
import com.solvd.warehouseProject.services.ProductCategoryService;
import com.solvd.warehouseProject.services.ProductService;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class Runner {

	private final static Logger LOGGER = LogManager.getLogger(Runner.class);

	public static void main(String[] args) {
		//creating company
		Company company = new Company("The Food Company");
		CompanyService companyService = new CompanyService();
		companyService.insert(company);
		
		//create a product category
		ProductCategory categoryA = new ProductCategory("Food", "All food products");
		ProductCategoryService prodCategoryService = new ProductCategoryService();
		prodCategoryService.insert(categoryA);
		
		//initialize some products
		Product productA = new Product ("Rice", "White refined rice", 0.5, LocalDate.parse("2020-06-17"), 2.50, categoryA);
		Product productB = new Product ("Flour", "White refined flour", 0.3, LocalDate.parse("2020-06-16"), 2.25, categoryA);
		Product productC = new Product ("Oatmeal", "Processed oatmeal", 0.6, LocalDate.parse("2020-06-20"), 5.0, categoryA);
		Product productD = new Product ("Sugar", "Refined sugar", 1.5, LocalDate.parse("2020-06-25"), 4.5, categoryA);
		ProductService productService = new ProductService();
		productService.insert(productA);
		productService.insert(productB);
		productService.insert(productC);
		productService.insert(productD);

		
		//initialize order details for each product
		OrderDetail orderDetailA = new OrderDetail (productA, 2400);
		OrderDetail orderDetailB = new OrderDetail (productB, 2500);
		OrderDetail orderDetailC = new OrderDetail (productC, 1800);
		OrderDetail orderDetailD = new OrderDetail (productD, 800);
		OrderDetailService detailService = new OrderDetailService();
		detailService.insert(orderDetailA);
		detailService.insert(orderDetailB);
		detailService.insert(orderDetailC);
		detailService.insert(orderDetailD);

		
		//creating an order and adding those order details to it
		Order orderA = new Order ();
		orderA.setDate(LocalDate.parse("2020-06-12"));
		orderA.setTotalVolume(50D);
		orderA.setTotalPrice(50D);
		orderA.addOrderDetail(orderDetailA);
		orderA.addOrderDetail(orderDetailB);
		orderA.addOrderDetail(orderDetailC);
		orderA.addOrderDetail(orderDetailD);
		
		OrderService orderService = new OrderService();
		orderService.insert(orderA);
		detailService.addToOrder(orderDetailA,orderA);
		detailService.addToOrder(orderDetailB,orderA);
		detailService.addToOrder(orderDetailC,orderA);
		detailService.addToOrder(orderDetailD,orderA);

		LOGGER.info("Unsorted order details:");
		orderA.getOrderDetails().forEach(od -> LOGGER.info(od.getProduct().getName()));
		
		//creating warehouses
		Warehouse warehouseA = new Warehouse ("Warehouse A", 1000.0, 800.0);
		Warehouse warehouseB = new Warehouse ("Warehouse B", 900.0, 700.0);
		Warehouse warehouseC = new Warehouse ("Warehouse C", 1500.0, 1300.0);
		Warehouse warehouseD = new Warehouse ("Warehouse D", 1400.0, 1200.0);
		Warehouse warehouseE = new Warehouse ("Warehouse E", 1200.0, 1000.0);
		
		//setting next warehouses & days to next
		warehouseA.setNextWarehouse(warehouseB);
		warehouseA.setDaysToNextWarehouse(2);
		
		warehouseB.setNextWarehouse(warehouseC);
		warehouseB.setDaysToNextWarehouse(4);
		
		warehouseC.setNextWarehouse(warehouseD);
		warehouseC.setDaysToNextWarehouse(5);
		
		warehouseD.setNextWarehouse(warehouseE);
		warehouseD.setDaysToNextWarehouse(3);
		
		
		//adding warehouses to company & closest warehouse
		company.setClosestWarehouse(warehouseA);
		company.setDaysToClosestWarehouse(3);
		
		company.getWarehouses().add(warehouseA);
		company.getWarehouses().add(warehouseB);
		company.getWarehouses().add(warehouseC);
		company.getWarehouses().add(warehouseD);
		company.getWarehouses().add(warehouseE);
		
		
		//creating a truck & adding it to the company
		Truck truckA = new Truck(5000.0);
		company.getTrucks().add(truckA);
		
		//adding order to truck
		try {
			truckA.addOrder(orderA);
		} catch (OrderVolumeExceededException e) {
			LOGGER.error(e);
		}
		
		/*orderA.getOrderDetails().forEach(orderDetail -> LOGGER.info(orderDetail.getProduct().getName()));
		
		orderA.getOrderDetails().forEach(orderDetail -> LOGGER.info(orderDetail.getSubtotalVolume()));
		
		orderA.getOrderDetails().forEach(orderDetail -> LOGGER.info(orderDetail.getProduct().getName()));*/
		
		/*List<OrderDetail> sortedOrderDetails = orderA.sortOrderDetails();
		LOGGER.info("Type of products sorted by totalPrice/daysToDueDate");
		sortedOrderDetails.forEach(od -> LOGGER.info(od.getProduct().getName()));*/
		
		LOGGER.info("Starting delivery");
		company.deliverOrder(truckA, orderA);
		LOGGER.info("End of delivery");
	}

}
