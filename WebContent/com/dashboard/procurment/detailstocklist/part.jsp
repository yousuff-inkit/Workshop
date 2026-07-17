<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
 <%@page import="com.dashboard.procurment.detailstocklist.ClsDetailStockListDAO"%>
 <% ClsDetailStockListDAO searchDAO = new ClsDetailStockListDAO();  
 
 String psrnossss=request.getParameter("psrnos")==null || request.getParameter("psrnos")==""?"0":request.getParameter("psrnos");  
 String load=request.getParameter("load")==null || request.getParameter("load")==""?"0":request.getParameter("load");  
 %>
 
<style>
#jqxInput{
	background-color:#fff;
	height: 20px;
	
}
</style>
 
  <script type="text/javascript"> 
  var dataAdapter ="";
	var st='<%=load%>';
	var psrnosss='<%=psrnossss%>';
            $(document).ready(function () {
             
            
             
            	
           	 var aa1= '<%=searchDAO.productsearch()%>';
 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'part_no', type: 'string'  },
                                 {name : 'productname', type: 'string'  },
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'unit', type: 'string'  },
                                 {name : 'unitdocno', type: 'string'  },
                                 {name : 'psrno', type: 'string'  },
                                 {name : 'specid', type: 'string'  },
                                  
                                 {name : 'unitprice', type: 'string'  },
                               
                              
                                 
                                 {name : 'brandname', type: 'string'  },    
                                 {name : 'taxper', type: 'number'  },
                                 
                                 {name : 'fixingprice', type: 'number'  },
                                 {name : 'mrp', type: 'number'  },
                                 {name : 'totstock', type: 'number'  },
                                 {name : 'rsv_qty', type: 'number'  },
                                 {name : 'balqty', type: 'number'  },
                                 
                             	    
                                 
                    ],
                    localdata: aa1,
                };
                  dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInput").jqxInput({ source: dataAdapter, displayMember: "productname", valueMember: "psrno", width: 200, height: 20});
                
                

                
            $("#jqxInput").on('select', function (event) {
            	  if (event.args) {
                      var item = event.args.item;
                      if (item) {
                          

                          for (var i = 0; i < dataAdapter.records.length; i++) { 
                              if (item.value == dataAdapter.records[i].psrno) {
                                 
                                  document.getElementById("psrno").value=dataAdapter.records[i].psrno;
                                 
                                  document.getElementById("prdname").innerText=""+dataAdapter.records[i].part_no;
                                	
                            		document.getElementById("brname").innerText=""+dataAdapter.records[i].brandname;
                            		
                                  
                                     funRoundAmt(dataAdapter.records[i].totstock,"stock"); 
                                   funRoundAmt(dataAdapter.records[i].rsv_qty,"rsv"); 
                                    funRoundAmt(dataAdapter.records[i].balqty,"bal"); 
                                   
                                     funRoundAmt(dataAdapter.records[i].fixingprice,"sellprice"); 
                                    funRoundAmt(dataAdapter.records[i].mrp,"mrp");
                                    
                                    funreload(event);
                          
                                  break;
                              }
                          }
                          

                           
                      }
                  }
                });  
            
            
            
            
            });
         

            if(st=="start")
        	{
       
            for (var i = 0; i < dataAdapter.records.length; i++) { 
            
                if (psrnosss == dataAdapter.records[i].psrno) {
                   
                    document.getElementById("psrno").value=dataAdapter.records[i].psrno;
                    
                    document.getElementById("jqxInput").value=dataAdapter.records[i].productname;
                   
                    document.getElementById("prdname").innerText=""+dataAdapter.records[i].part_no;
                  	
              		document.getElementById("brname").innerText=""+dataAdapter.records[i].brandname;
              		
                    
                       funRoundAmt(dataAdapter.records[i].totstock,"stock"); 
                     funRoundAmt(dataAdapter.records[i].rsv_qty,"rsv"); 
                      funRoundAmt(dataAdapter.records[i].balqty,"bal"); 
                     
                       funRoundAmt(dataAdapter.records[i].fixingprice,"sellprice"); 
                      funRoundAmt(dataAdapter.records[i].mrp,"mrp");
                      
                      funreload(event);
            
                    break;
                }
            }
            
        	
        	}
        
        </script>
         <input id="jqxInput" />
     