<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelDAO" %>
<%ClsModelDAO cma=new ClsModelDAO(); %>

<script type="text/javascript">
	var data= '<%=cma.getSearchDetails()%>';
    $(document).ready(function () { 	
    	var source =
            {
                datatype: "json",
                datafields: [
                         	{name : 'doc_no' , type: 'int' },
    						{name : 'vtype', type: 'String'  },
                         	{name : 'date', type: 'date'  },
                         	{name : 'brand_name',type:'String'},
                         	{name : 'brandid',type:'String'},
                         	{name : 'gname',type:'String'},
                         	{name : 'groupid',type:'String'},
                         	{name : 'enginesize',type:'string'},
                         	{name : 'enginesizedocno',type:'string'}
                 ],
                 localdata: data,
                
                
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
            $("#jqxModelSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                showfilterrow:true,
                filterable:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '10%' },
					{ text: 'Model', columntype: 'textbox', filtertype: 'input',datafield: 'vtype', width: '30%' },
					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Brand',columntype: 'textbox', filtertype: 'input',datafield:  'brand_name',width:'20%'},
					{ text: 'Brand ID',columntype: 'textbox', filtertype: 'input',datafield:  'brandid',width:'5%',hidden:true},
					{ text: 'Group',columntype: 'textbox', filtertype: 'input',datafield:  'gname',width:'12%'},
					{ text: 'Group ID',columntype: 'textbox', filtertype: 'input',datafield:  'groupid',width:'5%',hidden:true},
					{ text: 'Engine Size',columntype: 'textbox', filtertype: 'input',datafield:  'enginesize',width:'20%'},
					{ text: 'Engine Size Doc No',columntype: 'textbox', filtertype: 'input',datafield:  'enginesizedocno',width:'5%',hidden:true}
					]
            });
            $('#jqxModelSearch').on('rowdoubleclick', function (event) 
            		{
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxModelSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("model").value = $("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "vtype");
		                document.getElementById("txtgroupid").value= $('#jqxModelSearch').jqxGrid('getcellvalue', rowindex1, "groupid"); 
		                document.getElementById("txtgroup").value = $("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "gname");
		                $("#modeldate").jqxDateTimeInput('val',$("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "date"));
		                $("#brand").removeAttr('disabled');
		                $('#brand').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
		            	$('#cmbenginesize').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "enginesizedocno"));
		            	$('#window').jqxWindow('close');
            		 }); 
        });
    </script>
    <div id="jqxModelSearch"></div>