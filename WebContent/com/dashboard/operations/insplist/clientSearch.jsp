<%@page import="com.dashboard.operations.soldlist.*" %>
 <%ClsSoldListDAO solddao=new ClsSoldListDAO();
 String name=request.getParameter("name")==null?"":request.getParameter("name");
 String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
 String telephone=request.getParameter("telephone")==null?"":request.getParameter("telephone");
 String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
 String clientdate=request.getParameter("clientdate")==null?"":request.getParameter("clientdate");
 String id=request.getParameter("id")==null?"":request.getParameter("id");
 %>
 <script type="text/javascript">
 
 var clientdata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  var id='<%=id%>';
  if(id=="1"){ 
	  clientdata='<%=solddao.getClient(name,cldocno,telephone,mobile,clientdate,id)%>';  
  }
  else{
	  
  }
        $(document).ready(function () { 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  }, 
     						{name : 'refname', type: 'String'  },
     						{name : 'mobile', type: 'String'  },
     						{name : 'telephone', type: 'String'  },
     						{name : 'date', type: 'date' }
     						
                          	],
                          	localdata: clientdata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };

            $("#clientSearch").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#clientSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
					{ text: 'NAME', datafield: 'refname', width: '50%' },
					{ text: 'DATE', datafield: 'date', width: '10%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'MOBILE', datafield: 'mobile', width: '15%' },
					{ text: 'TELEPHONE', datafield: 'telephone', width: '15%' }					
					]
            });
    
            $('#clientSearch').on('rowdoubleclick', function (event) 
				{ 
				  var rowindex1=event.args.rowindex;
				  document.getElementById("client").value=$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "refname"); 
				  document.getElementById("hidclient").value=$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				  $('#clientwindow').jqxWindow('close');
				}); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="clientSearch"></div>
    
    </body>
</html>