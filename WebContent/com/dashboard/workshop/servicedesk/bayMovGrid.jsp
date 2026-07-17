<%@page import="com.dashboard.workshop.servicedesk.*" %>
<%ClsWSServiceDeskDAO floordao=new ClsWSServiceDeskDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
%>

<script type="text/javascript">
var id='<%=id%>';
var baymovdata=[];
if(id=="1"){
	baymovdata='<%=floordao.getBayMovData(id,jobcarddocno)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'bay' , type: 'string'},
 						{name : 'indate', type: 'date'},
 						{name : 'intime', type:'string'},
 						{name : 'inuser',type:'string'},
 						{name : 'inremarks',type:'string'},
                      	{name : 'outdate', type: 'date'  },
                      	{name : 'outtime',type:'string'},
                      	{name : 'outremarks',type:'string'},
                      	{name : 'outuser',type:'string'},
                      	{name : 'useddays',type:'number'}
                      	
                      	
             ],
             localdata: baymovdata,
            
            
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



        $("#bayMovGrid").jqxGrid(
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
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Bay',datafield: 'bay', width: '10%'},
    					{ text: 'In Date',datafield: 'indate', width: '7%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'In Time',datafield: 'intime', width: '6%'},
    					{ text: 'In User',datafield: 'inuser', width: '10%'},
    					{ text: 'In Remarks',datafield: 'inremarks', width: '15%'},
    					{ text: 'Out Date',datafield: 'outdate', width: '7%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Out Time',datafield: 'outtime', width: '6%'},
    					{ text: 'Out User',datafield: 'outuser', width: '10%'},
    					{ text: 'Out Remarks',datafield: 'outremarks', width: '15%'},
    					{ text: 'Used Days',datafield:'useddays',width:'10%',cellsformat:'d2'}
						
						
    	              ]
                });

	});
</script>
<div id="bayMovGrid"></div>