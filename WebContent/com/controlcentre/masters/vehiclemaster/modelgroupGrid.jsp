<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelDAO" %>
<%ClsModelDAO cma=new ClsModelDAO(); %>


<script type="text/javascript">
var data1;
      
	data1= '<%=cma.groupsearchDetails()%>';  

     $(document).ready(function () { 
     	
        // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
						{name : 'doc_no', type: 'number'   },
 						{name : 'gname', type: 'string'   },
 						{name : 'dates', type: 'date'  }
                    ],
            		    localdata: data1, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxGroupSearch").jqxGrid(
        {
            width: '100%',
            height: 350,
            source: dataAdapter,
            showfilterrow: true, 
            filterable: true, 
            selectionmode: 'singlerow',
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' },
						{ text: 'Group', datafield: 'gname', width: '60%' },
						{ text: 'Date', datafield: 'dates', width: '40%',cellsformat:'dd.MM.yyyy' },
					]
        });
        
         $('#jqxGroupSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
            document.getElementById("txtgroupid").value = $('#jqxGroupSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
        	document.getElementById("txtgroup").value = $('#jqxGroupSearch').jqxGrid('getcellvalue', rowindex1, "gname");
	       	
        	$('#groupinfowindow').jqxWindow('close'); 
        });  
    });
</script>
<div id="jqxGroupSearch"></div>
