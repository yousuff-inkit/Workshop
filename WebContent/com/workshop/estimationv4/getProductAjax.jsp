<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	Connection conn=null;
	JSONObject objdata=new JSONObject();
	try{
		ClsConnection objconn=new ClsConnection();
		ClsCommon objcommon=new ClsCommon();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String strsql="select * from ( select bd.brandname,m.fixingprice,m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,'' qty,sum(i.out_qty)"+
		" outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,round(coalesce(i.cost_price,0),2) unitprice"+
		" from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"+
		" on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"+
		" where m.status=3 group by i.prdid  order by i.date) a where 1=1 ";
				
		System.out.println(strsql);
		JSONArray productarray=new JSONArray();		
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("partno",rs.getString("partno"));
			objtemp.put("productname",rs.getString("productname"));
			objtemp.put("psrno",rs.getString("psrno"));
			objtemp.put("rate",rs.getString("unitprice"));
			productarray.add(objtemp);
		}
		
		objdata.put("productdata",productarray);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>