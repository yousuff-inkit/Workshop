package com.dashboard.operations.staffinvoicedsalik;

import java.sql.Connection;
import java.util.Timer;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import com.connection.ClsConnection;

public class SATContextListener implements ServletContextListener {

	private ScheduledExecutorService scheduler;

	@Override
	public void contextInitialized(ServletContextEvent event) {

		ClsConnection ClsConnection=new ClsConnection();

		Connection conn = ClsConnection.getMyConnection();
		com.dashboard.operations.staffinvoicedsalik.SATdownloadAction satdownload= new SATdownloadAction(); 

		Timer time = new Timer(); // Instantiate Timer Object
		//ScheduledTask st = new ScheduledTask(); // Instantiate SheduledTask class


		Statement stmtrun =null;
		ResultSet rsrun=null;
		long satperiod=0;

		try {
			rsrun = conn.createStatement().executeQuery("Select description from gl_config where field_nme='satautoperiod'");
			while(rsrun.next())
			{
				satperiod=rsrun.getLong("description");	
			}

			time.schedule(satdownload, 45000, satperiod);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		/*scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(new SomeDailyJob(), 0, 1, TimeUnit.DAYS);
        scheduler.scheduleAtFixedRate(new SomeHourlyJob(), 0, 1, TimeUnit.HOURS);
        scheduler.scheduleAtFixedRate(new SATdownloadAction(), 1, 8, TimeUnit.MINUTES);*/
	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		scheduler.shutdownNow();
	}

}


