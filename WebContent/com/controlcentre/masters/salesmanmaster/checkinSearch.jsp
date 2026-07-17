<%@page import="com.controlcentre.masters.salesmanmaster.checkin.ClsCheckinDAO" %>
<%ClsCheckinDAO ca=new ClsCheckinDAO(); %>
<script type="text/javascript">

	var data= '<%=ca.searchDetails() %>';
    
		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'sal_code', type: 'String'  },
                          	{name : 'sal_name', type: 'String'  },
                          	{name : 'date', type: 'String'  },
                          	{name : 'cldocno', type: 'String'  },
                          	{name : 'refname', type: 'String'  },
                          	{name : 'mobile',type:'String'},
                          	{name : 'mail',type:'String'},
                          	{name : 'active',type:'String'}
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
            $("#jqxCheckinSearch").jqxGrid(
            {
                width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,

                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Code', datafield: 'sal_code', width: '15%' },
					{ text: 'Name', datafield: 'sal_name', width: '40%' },
					{ text: 'Vendor No', datafield: 'cldocno', width: '40%',hidden:true },
					{ text: 'Vendor Name', datafield: 'refname', width: '35%',hidden:true },
					{ text:'Mobile',datafield:'mobile', width: '35%',hidden:false },
					{ text:'Mail',datafield:'mail', width: '40%',hidden:true },
					{ text:'Active',datafield:'active', width: '40%',hidden:true }
					]
            });
            $('#jqxCheckinSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxCheckinSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("cldocno").value = $("#jqxCheckinSearch").jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("refname").value = $("#jqxCheckinSearch").jqxGrid('getcellvalue', rowindex1, "refname");
                document.getElementById("code").value = $("#jqxCheckinSearch").jqxGrid('getcellvalue', rowindex1, "sal_code");
                document.getElementById("name").value = $("#jqxCheckinSearch").jqxGrid('getcellvalue', rowindex1, "sal_name");
                document.getElementById("mobile").value = $("#jqxCheckinSearch").jqxGrid('getcellvalue', rowindex1, "mobile");
                document.getElementById("mail").value = $("#jqxCheckinSearch").jqxGrid('getcellvalue', rowindex1, "mail");
                $("#checkindate").jqxDateTimeInput('val', $("#jqxCheckinSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("cmbactive").value = $("#jqxCheckinSearch").jqxGrid('getcellvalue', rowindex1, "active");
               
                $('#window').jqxWindow('close');
            }); 
         
        });
    </script>
    <div id="jqxCheckinSearch"></div>
