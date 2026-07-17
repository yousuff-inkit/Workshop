<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@ page import="com.operations.vehicletransactions.maintenanceworkorder.ClsmaintWorkorderDAO" %>
<%ClsmaintWorkorderDAO cmwd=new ClsmaintWorkorderDAO(); %>
<%String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");%>
<script type="text/javascript"> 
var postdetailsdata;
var id='<%=id%>';
if(id=="1"){
	postdetailsdata='<%=cmwd.getPostDetailsData(docno,id)%>';
}
    $(document).ready(function () { 	
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'maindocno' , type: 'number' },
 						{name : 'mainvocno', type: 'string'  },
 						{name : 'inspdocno', type: 'string'  },
 						{name : 'amount',type:'number'},
 						{name : 'invoiced' , type: 'string' },
 						{name : 'damagename',type:'string'}
 								
 						],
             localdata: postdetailsdata,
            
            
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
        $("#postDetailsGrid").jqxGrid(
        {
            width: '100%',
            height: 300,
            source: dataAdapter,
            //disabled: true,
            editable:false,
            altRows: true,
            selectionmode: 'singlerow',
            pagermode: 'default',
         
          

            columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '10%',
					    cellsrenderer: function (row, column, value) {
					        return "<left><div style='margin:4px;'>" + (value + 1) + "</div></left>"; 
					    }  
					},
					{ text:'Doc No Original',datafield:'maindocno',width:'10%',hidden:true},
					{ text:'Doc No',datafield:'mainvocno',width:'22.5%'},
					{ text:'Inspection No',datafield:'inspdocno',width:'22.5%'},
					{ text:'Amount',datafield:'amount',width:'22.5%',cellsalign:'right',align:'right',cellsformat:'d2'},
					{ text:'Invoice',datafield:'invoiced',width:'22.5%'}
        			] 
        }); 
       
    }); 
</script>
<div id="postDetailsGrid"></div>


