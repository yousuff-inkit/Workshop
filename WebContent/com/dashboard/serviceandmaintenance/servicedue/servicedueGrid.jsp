<%@page import="com.dashboard.serviceandmaintenance.servicedue.ClsServiceDue"%>
<%ClsServiceDue DAO= new ClsServiceDue(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String avgkm = request.getParameter("avgkm")==null?"0":request.getParameter("avgkm").trim();
	 String uptoDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
//     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
   %>
     <% String contextPath=request.getContextPath();%>
<script type="text/javascript">
      var servicedata;
      var servicedueGridexceldata;
      var temp='<%=branchval%>';
     <%--  var temp1='<%=type%>'; --%>
      
	  	if(temp!='NA'){ 
	  		servicedata='<%=DAO.servicedueGridLoading(branchval, avgkm, uptoDate)%>';
	  		<%--  servicedueGridexceldata='<%=DAO.servicedueGridLoading(branchval, avgkm, uptoDate) %>'; --%>
	  	}
	  	
  	
        $(document).ready(function () {
        	var source =
            {
                datatype: "json",
                datafields: [
                           
							{name : 'regplt' , type: 'string' },
							{name : 'fleetno' , type: 'String' },
							{name : 'fleetname' , type:'string'},
							{name : 'refno' , type:'string'},
							{name : 'reftype' , type:'string'},
							{name : 'client' , type:'string'},
							
							{name : 'mobno' , type:'string'},
							{name : 'lstservicekm' , type:'string'},
							{name : 'nxtservicekm' , type:'string'},
							{name : 'curkm' , type:'string'}
					      ],
                          localdata: servicedata,
               
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
            $("#servicedueGrid").jqxGrid(
            {
                width: '98%',
                height: 535,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
               columnsresize:true,
                
                columns: [
{ text: 'SL#', sortable: false, filterable: false, editable: false, 
    editable: false, draggable: false, resizable: false,
    datafield: 'sl', columntype: 'number', width: '4%',
    cellsrenderer: function (row, column, value) {
        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    }  
  },

							{ text: 'Reg No',  datafield: 'regplt',  width: '9%' },
							{ text: 'Fleet No', datafield: 'fleetno', width: '9%' },
							{ text: 'Fleet Name',  datafield: 'fleetname',  width: '12%' },
							
							{ text: 'Ref No.',  datafield: 'refno',  width: '9%' },
							{ text: 'Ref Type',  datafield: 'reftype',   width: '5%'  },
							{ text: 'Client Name', datafield:'client', width:'14%' },
							{ text: 'Mob No', datafield:'mobno', width:'8%' },
							{ text: 'Last Service KM', datafield:'lstservicekm', width:'10%' },
							{ text: 'Next Service KM', datafield:'nxtservicekm', width:'10%' },
							{ text: 'Current KM', datafield:'curkm', width:'10%' },
						 ]
            });
            
           /*  if(temp=='NA'){
                $("#servicedueGrid").jqxGrid("addrow", null, {});
            } */
            
            $("#overlay, #PleaseWait").hide();
            
           

        });

</script>
<div id="servicedueGrid"></div>
