 <%@page import="com.dashboard.trafficfine.ClsTrafficfineDAO" %>
<%ClsTrafficfineDAO ctd=new ClsTrafficfineDAO(); %>
 
 
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 String contactNo = request.getParameter("contactNo")==null?"0":request.getParameter("contactNo");
 %>
<script type="text/javascript">
  
	    var data='<%=ctd.clientDetails(cldocno, partyname, contactNo)%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'cldocno', type: 'int'   },
     						{name : 'refname', type: 'string'   },
     						{name : 'address', type: 'string'  },
     						{name : 'per_mob', type: 'int'   }
     						
                        ],
                		
                 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientsearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                       
                columns: [
							{ text: 'Doc No',  datafield: 'cldocno', width: '10%' },
							{ text: 'Name', datafield: 'refname', width: '20%' },
							{ text: 'Address', datafield: 'address', width: '55%' },
							{ text: 'Contact', datafield: 'per_mob', width: '15%' },
						]
            });
            
          $('#clientsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtclientname").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex2, "refname");
                document.getElementById("txtcldocno").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
                
               $('#clientDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="clientsearch"></div>