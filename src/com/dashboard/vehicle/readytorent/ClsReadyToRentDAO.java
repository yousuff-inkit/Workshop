package com.dashboard.vehicle.readytorent;

import java.sql.*;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.connection.*;
import com.common.*;

public class ClsReadyToRentDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getBranchwiseData(String check) throws SQLException
	{
		if(!check.equalsIgnoreCase("1")){
			return null;
		}
		JSONArray RESULTDATA=new JSONArray();
		JSONArray ROWDATA=new JSONArray();
		JSONArray COLUMNDATA=new JSONArray();
		Connection conn =  null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			ArrayList<String> columnsarray=new ArrayList<>();
			
			columnsarray.add("Sr No::id::center::center:: ::5%:: :: :: ");
			columnsarray.add("Ref No::refno::center::center:: ::10%:: :: :: ");
			columnsarray.add("Description::description::left::left:: :: :: :: :: ");
			
			String strbranch="select doc_no,branchname from my_brch where status=3";
			ResultSet rsbranch=stmt.executeQuery(strbranch);
			String branchname="";
			int y=0;
			int branchcount=1;
			while(rsbranch.next()){
				branchname=rsbranch.getString("branchname");
				columnsarray.add(""+branchname+"::branch"+y+"::right::right:: ::12%:: :: ::['sum']");
				y++;
				branchcount++;
			}
			columnsarray.add("BranchCount::brcount::right::right::true::8%:: :: :: ");
			System.out.println("Branch Count:"+branchcount);
			ArrayList<ArrayList<String>> rowsarray= new ArrayList<ArrayList<String>>();
			/*String strfinal="select (select count(*) from my_brch where status=3 ) brcount,a.st_desc,coalesce(sum(a.branch0),0) branch0,coalesce(sum(a.branch1),0) branch1,coalesce(sum(a.branch2),0) branch2,"+
			" coalesce(sum(a.branch3),0) branch3,coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,coalesce(sum(a.branch6),0) branch6,"+
			" coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9 from (select st.st_desc,"+
			" if(veh.a_br=1,count(*),0) branch0,if(veh.a_br=2,count(*),0) branch1, if(veh.a_br=3,count(*),0) branch2,if(veh.a_br=4,count(*),0) branch3,"+
			" if(veh.a_br=5,count(*),0) branch4, if(veh.a_br=6,count(*),0) branch5,if(veh.a_br=7,count(*),0) branch6,if(veh.a_br=8,count(*),0) branch7, "+
			" if(veh.a_br=9,count(*),0) branch8,if(veh.a_br=10,count(*),0) branch9 from gl_vehmaster veh left join gl_status st on (veh.tran_code=st.status)"+
			" where veh.statu=3 and veh.fstatus<>'Z' group by veh.doc_no) a group by a.st_desc";*/
			String strfinal="select (select count(*) from my_brch where status=3 ) brcount,a.st_desc,coalesce(sum(a.branch0),0) branch0,coalesce(sum(a.branch1),0) "+
			" branch1,coalesce(sum(a.branch2),0) branch2,coalesce(sum(a.branch3),0) branch3,coalesce(sum(a.branch4),0) branch4,coalesce(sum(a.branch5),0) branch5,"+
			" coalesce(sum(a.branch6),0) branch6,coalesce(sum(a.branch7),0) branch7,coalesce(sum(a.branch8),0) branch8,coalesce(sum(a.branch9),0) branch9 from ("+
			" select veh.fleet_no,lag.doc_no,st.st_desc,case when veh.tran_code='RA' then rag.brhid=1 when veh.tran_code='LA' then lag.brhid=1"+
			" else veh.a_br=1 end branch0,case when veh.tran_code='RA' then rag.brhid=2 when veh.tran_code='LA' then lag.brhid=2"+
			" else veh.a_br=2 end branch1,case when veh.tran_code='RA' then rag.brhid=3 when veh.tran_code='LA' then lag.brhid=3"+
			" else veh.a_br=3 end branch2,case when veh.tran_code='RA' then rag.brhid=4 when veh.tran_code='LA' then lag.brhid=4"+
			" else veh.a_br=4 end branch3,case when veh.tran_code='RA' then rag.brhid=5 when veh.tran_code='LA' then lag.brhid=5"+
			" else veh.a_br=5 end branch4,case when veh.tran_code='RA' then rag.brhid=6 when veh.tran_code='LA' then lag.brhid=6"+
			" else veh.a_br=6 end branch5,case when veh.tran_code='RA' then rag.brhid=7 when veh.tran_code='LA' then lag.brhid=7"+
			" else veh.a_br=7 end branch6,case when veh.tran_code='RA' then rag.brhid=8 when veh.tran_code='LA' then lag.brhid=8"+
			" else veh.a_br=8 end branch7,case when veh.tran_code='RA' then rag.brhid=9 when veh.tran_code='LA' then lag.brhid=9"+
			" else veh.a_br=9 end branch8,case when veh.tran_code='RA' then rag.brhid=10 when veh.tran_code='LA' then lag.brhid=10"+
			" else veh.a_br=10 end branch9 from gl_vehmaster veh inner join (select max(doc_no) doc,fleet_no from gl_vmove group by fleet_no) v"+
			" on v.fleet_no=veh.fleet_no inner join gl_vmove vm on vm.doc_no=v.doc left join gl_ragmt rag on rag.doc_no=vm.rdocno and"+
			" vm.rdtype='RAG' and veh.tran_code='RA' left join gl_lagmt lag on lag.doc_no=vm.rdocno and vm.rdtype='LAG' and veh.tran_code='LA'"+
			" left join gl_status st on (veh.tran_code=st.status) where veh.statu=3 and veh.fstatus<>'Z' group by veh.fleet_no"+
			" ) a group by a.st_desc";
			ResultSet rsfinal=stmt.executeQuery(strfinal);
			int id=1;
			
			
			while(rsfinal.next()){
				ArrayList<String> temp=new ArrayList<String>();
				temp.add(id+"");
				temp.add(id+"");
				temp.add(rsfinal.getString("st_desc"));
				temp.add(rsfinal.getString("brcount"));
				temp.add(rsfinal.getString("branch0"));
				temp.add(rsfinal.getString("branch1"));
				temp.add(rsfinal.getString("branch2"));
				temp.add(rsfinal.getString("branch3"));
				temp.add(rsfinal.getString("branch4"));
				temp.add(rsfinal.getString("branch5"));
				temp.add(rsfinal.getString("branch6"));
				temp.add(rsfinal.getString("branch7"));
				temp.add(rsfinal.getString("branch8"));
				temp.add(rsfinal.getString("branch9"));
				id++;
			
				rowsarray.add(temp);
			}
			
			COLUMNDATA=convertColumnAnalysisArrayToJSON(columnsarray);
			 ROWDATA=convertRowAnalysisArrayToJSON(rowsarray);
			 
			 JSONArray analysisarray=new JSONArray();
			 
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(ROWDATA);
			 RESULTDATA=analysisarray;
			System.out.println("Check"+analysisarray);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}

	private JSONArray convertRowAnalysisArrayToJSON(
			ArrayList<ArrayList<String>> rowsarray) {
		// TODO Auto-generated method stub
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsarray.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsarray.get(i);
			
			int length = analysisRowArray.size();
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("refno",analysisRowArray.get(1));
			obj.put("description",analysisRowArray.get(2));
			obj.put("brcount",analysisRowArray.get(3));
			for (int j = 4,k=0; j < length; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("branch"+k,analysisRowArray.get(j));
				}
			}
			
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;}

	private JSONArray convertColumnAnalysisArrayToJSON(
			ArrayList<String> columnsarray) {
		// TODO Auto-generated method stub
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsarray.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnArray=columnsarray.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}
			if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregates",analysisColumnArray[8]);
			}
			/*if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregatesrenderer","rendererstring");
			}*/
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
	}
}
