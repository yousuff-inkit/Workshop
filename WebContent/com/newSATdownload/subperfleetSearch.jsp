<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 
 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.NewSatDownload.SATdownloadDAO" %>
       <% SATdownloadDAO DAO=new SATdownloadDAO();
String fleetno = request.getParameter("fleetno")==null?"NA":request.getParameter("fleetno");
String regno = request.getParameter("regno")==null?"NA":request.getParameter("regno");
String flname = request.getParameter("flname")==null?"NA":request.getParameter("flname");
String stag = request.getParameter("stag")==null?"NA":request.getParameter("stag");
String pcode = request.getParameter("pcode")==null?"NA":request.getParameter("pcode");

String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa");


%>
 <script type="text/javascript">

 var vehdata1='<%=DAO.vehSearch(session,fleetno,regno,flname,stag,pcode,aa)%>';
   // alert(data);
  /*  var url1='disfleetSearch.jsp'; */
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
            		
                datatype: "json",
                datafields: [
                          	{name : 'reg_no' , type: 'number' },
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     						{name : 'salik_tag', type: 'String'  },
     						{name : 'platecode',type:'string'}
     				        ],
             
                          	localdata: vehdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxfleetsearch").jqxGrid(
            {
                width: '100%',
                height: 340,
                source: dataAdapter,
                columnsresize: true,
              
             /*  filterable: true,
              showfilterrow: true, */
                selectionmode: 'singlerow',
                pagermode: 'default',
              
                //Add row method
	
                columns: [
					{ text: 'FLEETNO', datafield: 'fleet_no', width: '13%' },
					{ text: 'REGNO', datafield: 'reg_no', width: '17%' },
					{ text: 'NAME', datafield: 'flname', width: '40%'  },
					{ text: 'SALIK TAG', datafield: 'salik_tag', width: '15%'},
					{ text: 'PLATE CODE',datafield:'platecode',width:'15%'}
		
					
					]
            });
            
            $('#jqxfleetsearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
            	
            	document.getElementById("txtxslregno").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "reg_no"); 
               document.getElementById("txtsalikfleetno").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
               document.getElementById("txtsalfleetnme").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "flname");
               document.getElementById("txtsalplcode").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "platecode");
               document.getElementById("txtsaliktagno").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "salik_tag");
                    
                $('#vehinfowindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="jqxfleetsearch"></div>