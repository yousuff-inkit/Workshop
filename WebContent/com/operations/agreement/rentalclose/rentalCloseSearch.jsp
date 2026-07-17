<%@page import="com.operations.agreement.rentalclose.ClsRentalCloseDAO"%>
<%ClsRentalCloseDAO closedao=new ClsRentalCloseDAO(); %>
<script type="text/javascript">
  var datasearch='<%=closedao.getSearchDetails()%>';
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
            $("#rentalCloseSearch").jqxGrid(
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
          var rows=$('#rentalCloseSearch').jqxGrid('getrows');
          if(rows.length==0){
            $("#rentalCloseSearch").jqxGrid("addrow", null, {});
            }
          $('#rentalCloseSearch').on('rowdoubleclick', function (event) 
        		  { 
        	  var row1=event.args.rowindex;
        	  document.getElementById("docno").value=$('#rentalCloseSearch').jqxGrid('getcellvalue', row1, "doc_no");
        	  $("#closedate").jqxDateTimeInput('val',$("#rentalCloseSearch").jqxGrid('getcellvalue', row1, "date"));
        	  document.getElementById("agreementno").value=$('#rentalCloseSearch').jqxGrid('getcellvalue', row1, "agmtno");
        		$('#window').jqxWindow('close');
        		document.getElementById("mode").value="view";
        		document.getElementById("frmRentalClose").submit();
        		  });
      });
        
            </script>
            <div id="rentalCloseSearch"></div>