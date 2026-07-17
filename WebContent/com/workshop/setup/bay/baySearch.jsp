<%@page import="com.workshop.setup.bay.*" %>
<%ClsWorkBayDAO dao=new ClsWorkBayDAO();
String check=request.getParameter("check")==null?"0":request.getParameter("check");
%>
<script type="text/javascript">
var baysearchdata;
var id='<%=check%>';
if(id=="1"){
	   baysearchdata='<%=dao.loadgrid()%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'doc_no' , type: 'number' },
 						{name : 'code', type: 'string'  },
                      	{name : 'name', type: 'string'  },
                      	{name : 'jobtype',type:'string'},
                      	{name : 'jobtypeid',type:'string'},
                      	{name : 'date',type:'date'}
             ],
             localdata: baysearchdata,
            
            
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



        $("#baysearchGrid").jqxGrid(
                {
                	width: '100%',
                    height: 350,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  //  pagermode: 'default',
                    sortable: true,
                    //pageable: true,
                    altrows:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '8%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Doc No',datafield: 'doc_no', width: '10%' },
    					{ text: 'Date',datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
    					{ text: 'Code',datafield: 'code', width: '15%' },
    					{ text: 'Name',datafield: 'name', width: '40%' },
    					{ text: 'Job Type',datafield:'jobtype',width: '15%'},
    					{ text: 'Job Type Id', datafield: 'jobtypeid', width: '10%',hidden:true }

    	              ]
                });

        $('#baysearchGrid').on('rowdoubleclick', function (event) 
        		{    
                var row1=event.args.rowindex;
    			$('#docno').val($('#baysearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
    			$('#code').val($('#baysearchGrid').jqxGrid('getcellvalue',row1,'code'));
    			$('#cmbjobtype').val($('#baysearchGrid').jqxGrid('getcellvalue',row1,'jobtypeid'));
    			$('#name').val($('#baysearchGrid').jqxGrid('getcellvalue',row1,'name'));
    			$('#date ').jqxDateTimeInput('setDate',$('#baysearchGrid').jqxGrid('getcellvalue',row1,'date'));
    			 $('#window').jqxWindow('hide');
                });
            
            
	
        		
	});
</script>
<div id="baysearchGrid"></div>