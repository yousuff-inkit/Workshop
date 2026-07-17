<%@page import="com.operations.agreement.leaseclose.ClsLeaseCloseDAO"%>
<%ClsLeaseCloseDAO leasedao=new ClsLeaseCloseDAO(); %>
<script type="text/javascript">
  var datasearch='<%=leasedao.getSearchDetails()%>';
     // alert(temp);
        $(document).ready(function () { 	
            
        	 
            var num = 0;
        
            var source =
            {
                datatype: "json",
                datafields: [

{name : 'doc_no' , type: 'string' },
	{name : 'date' , type:'date'},
	{name : 'agmtno' , type:'string'},
	
                 ],
                localdata: datasearch,
                //url: url,
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
            $("#leaseCloseSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                //rowsheight:18,
                source: dataAdapter,
                columnsresize: true,
                pageable: false,
               // editable:true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
{ text: 'Doc No', datafield: 'doc_no', width: '33.33%'},
{ text: 'Date',  datafield: 'date',  width: '33.33%',cellsformat:'dd.MM.yyyy'},
{ text: 'Agreement No',  datafield: 'agmtno',  width: '33.33%'  },


	              ]
            });
          var rows=$('#leaseCloseSearch').jqxGrid('getrows');
          if(rows.length==0){
            $("#leaseCloseSearch").jqxGrid("addrow", null, {});
            }
          $('#leaseCloseSearch').on('rowdoubleclick', function (event) 
        		  { 
        	  var row1=event.args.rowindex;
        	  document.getElementById("docno").value=$('#leaseCloseSearch').jqxGrid('getcellvalue', row1, "doc_no");
        	  $("#closedate").jqxDateTimeInput('val',$("#leaseCloseSearch").jqxGrid('getcellvalue', row1, "date"));
        	  document.getElementById("agreementno").value=$('#leaseCloseSearch').jqxGrid('getcellvalue', row1, "agmtno");
        		$('#window').jqxWindow('close');
        		document.getElementById("mode").value="view";
        		document.getElementById("frmLeaseClose").submit();
        		  });
      });
        
            </script>
            <div id="leaseCloseSearch"></div>