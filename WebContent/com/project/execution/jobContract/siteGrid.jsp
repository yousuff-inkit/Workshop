<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsJobContractDAO DAO= new ClsJobContractDAO(); %>
 <%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 
 %>
    <script type="text/javascript">
    var sitedata;
    var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    var trno='<%=trno%>';
    
    $(document).ready(function () { 
    	chkserviceteam();
    	if(gridload=="1" && trno>0){
    		sitedata = '<%=DAO.siteRefGridLoad(session,trno) %>';
        
        }
    	
    	 if(docno>0){
    		sitedata='<%=DAO.siteGridLoad(session,docno)%>';
    		
    	} 
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'site', type: 'String'  },
                          	{name : 'area', type: 'String'  },
                          	
                          	{name : 'siteadd', type: 'String'  },
                          	{name : 'contid', type: 'String'  },
                          	{name : 'contper', type: 'String'  },
                          	{name : 'contmob', type: 'String'  },
                          	
                          	{name : 'amount', type: 'String'  },
                          	{name : 'areaid', type: 'String'  },
                          	{name : 'rowno', type: 'String'  },
                          	{name : 'serviceteam', type: 'String'  },
                        	{name : 'steamid', type: 'String'  },
                          	],
                 localdata: sitedata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#siteGrid").jqxGrid(
            {
                width: '100%',
                height: 140,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site', width: '25%' },
					{text: 'Service Team', datafield: 'serviceteam', width: '10%' , editable:false  },
					{text: 'steamid',datafield:'steamid',width:'25%',editable:false,hidden:true},
					{text: 'Address',datafield:'siteadd',width:'20%',editable:true},
					{text: 'Contact Person',datafield:'contper',width:'20%',editable:false},
					{text: 'Contact Tel',datafield:'contmob',width:'10%',editable:false},
					{text: 'Area',datafield:'area',width:'20%',editable:false},
					{text: 'Areaid',datafield:'areaid',width:'25%',editable:false,hidden:true},
					{text: 'contid',datafield:'contid',width:'25%',editable:false,hidden:true},
					{text: 'rowno',datafield:'rowno',width:'25%',hidden:true},
					]
            });
            
            $('#siteGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="area"))
	    	   {
 		    	 getareas(rowBoundIndex);
	    	   }
 		     if((datafield=="serviceteam"))
	    	   {
		    	 getserviceteam(rowBoundIndex);
	    	   }
 		     if(datafield=="contper")
	    	   {
 		    	var clientid=document.getElementById("clientid").value;
 		  		
 		  		if(clientid==""){
 		  			document.getElementById("errormsg").innerText=" Select Client";
 		  			return 0;
 		  		}
 		  		var type=2;
 		  		 $('#cpinfowindow').jqxWindow('open');
 	  	       cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid+'&rowindex='+rowBoundIndex+'&type='+type); 
 		  		
	    	   }
            			
            		});
            
            if($('#mode').val()=='view'){
                
          		 $("#siteGrid").jqxGrid({ disabled: true});
              }
                 
            $("#siteGrid").jqxGrid('addrow', null, {});
        });
    function chkserviceteam()
    {
     
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText.trim();
	     
	      if(parseInt(items)>0)
	       {
	     
	    	  
	    	  $('#siteGrid').jqxGrid('showcolumn', 'serviceteam');
	    
	    	  
	    	  
	        }
	          else
	      {
	      
	        	  $('#siteGrid').jqxGrid('hidecolumn', 'serviceteam');
	      
	      }
	      
	       }}
	   x.open("GET","checkserviceteam.jsp?",true);
		x.send();
	 
	      
	        
    	
    }
    </script>
    <div id="siteGrid"></div>
