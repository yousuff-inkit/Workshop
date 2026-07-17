<%@page import="com.dashboard.workshop.gateoutpassdetails.ClsGOPDetailsDAO" %>
<%ClsGOPDetailsDAO floordao=new ClsGOPDetailsDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
%>

<script type="text/javascript">
var id='<%=id%>';
var selectedteamsdata=[];
if(id=="1"){
	selectedteamsdata='<%=floordao.getSelectedTeamsData(id,jobcarddocno)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'bay' , type: 'string'},
                      	{name : 'description',type:'string'}
                      	
             ],
             localdata: selectedteamsdata,
            
            
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



        $("#selectedTeamsGrid").jqxGrid(
                {
                	width: '100%',
                    height: 300,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Bay',datafield: 'bay', width: '40%'},
    					{ text: 'Team',datafield: 'description',width:'50%'}
    	              ]
                });

	});
</script>
<div id="selectedTeamsGrid"></div>