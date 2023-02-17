$(document).on("turbolinks:load", function() {
    // $("#searchform").on("keyup",function() {
    //     const value = $(this).val().toLowerCase();
    //     $.ajax({
    //         url: '/items',
    //         type: 'GET',
    //         data: {search: value},
    //         dataType: 'script'
    //     });
    // });

    $("table[role='datatable']").each(function (e) {
        var oTable = $(this).DataTable({
            dom: 'Bfrtip',
            "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],

            bProcessing: true,
            bServerSide: true,
            bLengthChange: true,
            bInfo: true,
            language: {search: "Search : ", searchPlaceholder: "search"},
            "ordering": true,
            "order": [],
            "aoColumnDefs": [
                {'bSortable': false, 'aTargets': [-1, "no-sort"]}
            ],
            sAjaxSource: $(this).data('source')
        });
    });

});