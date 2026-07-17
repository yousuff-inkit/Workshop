<%@page import="com.dashboard.analysis.utilization.ClsVehUtilizationDAO" %>
<% ClsVehUtilizationDAO cvd=new ClsVehUtilizationDAO();%>
 
 <%
 	String branch=request.getParameter("branch")==null?"":request.getParameter("branch").trim();
 	String id=request.getParameter("id")==null?"":request.getParameter("id").trim();
 	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
 	String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim();
 	String fleet=request.getParameter("fleet")==null?"":request.getParameter("fleet").trim();
    String duration=request.getParameter("duration")==null?"":request.getParameter("duration").trim();      
    String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
    String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
    String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
    String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom");
    String grpby1=request.getParameter("grpby1")==null?"":request.getParameter("grpby1");
 	%> 
    <style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
        }
</style>
             	  
<script type="text/javascript">
 var temp4='<%=branch%>';
var utilizedata,utilizedataexcel;
if(temp4!='')
{ 
	 utilizedata='<%=cvd.getVehUtilize(branch,fromdate,todate,fleet,id,duration,grpby1,hidbrand,hidmodel,hidgroup,hidyom)%>';
	 utilizedataexcel='<%=cvd.getVehUtilizeExcel(branch,fromdate,todate,fleet,id,duration,grpby1,hidbrand,hidmodel,hidgroup,hidyom)%>';
	
}
else
{
	
	utilizedata;
	} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		
					/* 	{name : 'brand_name', type: 'string'  },
						{name : 'model', type: 'string'  },
						{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'yom', type: 'string'  }, */
						{name : 'color', type: 'string'  },
						{name : 'refno',type:'number'},
						{name : 'description',type:'String'},
					 	{name : 'reg_no', type: 'string'  },
					 	/*	{name : 'gname', type: 'string'  }, */
						
						{name : 'purdate',type:'date'},
						{name : 'saledate',type:'date'},
						{name : 'total',type:'number'},
						{name : 'rental',type:'number'},
						{name : 'garage',type:'number'},
						{name : 'staff',type:'number'},
						{name : 'readytorent',type:'number'},
						{name : 'transfer',type:'number'},
						{name : 'delivery',type:'number'},
						{name : 'unrentable',type:'number'},
						{name : 'forsale',type:'number'},
						{name : 'other',type:'number'}
						
						],
				    localdata: utilizedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#vehUtilizeGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    var cellclassname =  function (row, column, value, data) {


  var ss= $('#vehUtilizeGrid').jqxGrid('getcellvalue', row, "days");
	          if(parseInt(ss)<0)
	  		{
	  		
	  		return "yellowClass";
	  	
	  		}
    
    	/* return "greyClass";
    	
	        var element = $(defaultHtml);
	        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
	        return element[0].outerHTML;
*/

	}
        
    
    $("#vehUtilizeGrid").jqxGrid(
    {
        width: '98%',
        height: 513,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
    						groupable: false, draggable: false, resizable: false,datafield: '',
    						columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
    						cellsrenderer: function (row, column, value) {
     							return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
  								}    
					},
					{ text: 'Ref No', datafield: 'refno', width: '7%'  ,cellclassname: cellclassname },
					{ text: 'Description',datafield: 'description',width:'15%',cellclassname:cellclassname},
					
					{ text: 'Purchase Dt.', datafield: 'purdate', width: '8%' ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy' },
					{ text: 'Sale Dt.', datafield: 'saledate', width: '7%'  ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'  },
					{ text: 'Live In', datafield: 'total', width: '8%'  ,cellclassname: cellclassname,cellsformat:'f2',align:'right',cellsalign:'right' },
					{ text: 'Rent Dur.', datafield: 'rental', width: '8%'  ,cellclassname: cellclassname,cellsformat:'f2',align:'right',cellsalign:'right'},
					{ text: 'Delivery Dur.', datafield: 'delivery', width: '7%'  ,cellclassname: cellclassname ,cellsformat:'f2',align:'right',cellsalign:'right'},
					{ text: 'Transfer Dur.', datafield: 'transfer', width: '7%'  ,cellclassname: cellclassname ,cellsformat:'f2',align:'right',cellsalign:'right'},
					{ text: 'Garage Dur.', datafield: 'garage', width: '7%'  ,cellclassname: cellclassname ,cellsformat:'f2',align:'right',cellsalign:'right'},
					{ text: 'Staff Dur.', datafield: 'staff', width: '7%'  ,cellclassname: cellclassname ,cellsformat:'f2',align:'right',cellsalign:'right'},
				/*  { text: 'Ready to Rent', datafield: 'readytorent', width: '8%'  ,cellclassname: cellclassname ,cellsformat:'f2',align:'right',cellsalign:'right'},
					{ text: 'Unrentable', datafield: 'unrentable', width: '8%'  ,cellclassname: cellclassname ,cellsformat:'f2',align:'right',cellsalign:'right'}, */
					{ text: 'For Sale', datafield: 'forsale', width: '7%'  ,cellclassname: cellclassname ,cellsformat:'f2',align:'right',cellsalign:'right'},
					{ text: 'Other', datafield: 'other', width: '7%'  ,cellclassname: cellclassname ,cellsformat:'f2',align:'right',cellsalign:'right'}
					/* { text: 'Staff Type', datafield: 'renttype', width: '5%' ,cellclassname: cellclassname },
					{ text: 'Idle days', datafield: 'idealdys', width: '10%' ,cellsalign: 'right', align:'right',cellclassname: 'advanceClass'}, */
											
						]
    
    });
    
    


    
});

	
	
</script>
<div id="vehUtilizeGrid"></div>