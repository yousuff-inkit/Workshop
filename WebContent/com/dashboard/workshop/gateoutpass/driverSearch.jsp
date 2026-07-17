<%@page import="com.dashboard.workshop.gateoutpass.*" %>
<% ClsGateOutPassDAO DAO=new ClsGateOutPassDAO(); %>  
<%@page import="javax.servlet.http.HttpServletRequest" %> 
<%@page import="javax.servlet.http.HttpSession" %>   
 
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
	  
}   
</style>
<script type="text/javascript">  
        var cdata2= '<%=DAO.driversearch()%>';              
            $(document).ready(function ()   {
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'driver', type: 'string'  },  
                    ],
                    localdata: cdata2,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);  
                // Create a jqxInput  
                /*  $('#jqxInputDriver').on('change', function (event) {
                	 console.log($('#jqxInputDriver').val()+"======="+$('#driverid').val());    
                	 console.log("daa==="+$("#jqxInputDriver").jqxInput('val').value);  
                }); */  
                $("#jqxInputDriver").jqxInput({ source: dataAdapter, displayMember: "driver", valueMember: "driver", items: 20 ,width: '78%', height: 20,placeHolder: "Driver Name"});
                $("#jqxInputDriver").on('select', function (event) {      
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {   
                                	  document.getElementById("driverid").value=dataAdapter.records[i].driver;        
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });  
        </script>
         <input type="text" id="jqxInputDriver"  class="p-l-5 input-sm form-control"/>       