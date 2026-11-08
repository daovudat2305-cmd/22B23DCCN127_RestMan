<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #212529;
    }
    .restman-navbar {
        background-color: #8e0e00;
    }
    .restman-card {
        background: #ffffff;
        border: 1px solid #dee2e6;
        border-radius: 8px;
    }
    .btn-restman {
        background-color: #8e0e00;
        color: #fff;
        border-radius: 6px;
        font-weight: 600;
        border: 1px solid #8e0e00;
    }
    .btn-restman:hover {
        background-color: #720b00;
        color: #fff;
        border-color: #720b00;
    }
    /* Bỏ hiệu ứng chuyển động, rung nảy khi hover */
    .btn, .btn:hover, .btn-restman, .btn-restman:hover, .restman-card, .table {
        transition: none !important;
        transform: none !important;
    }
    .table-restman thead {
        background-color: #212529;
        color: #ffffff;
    }
    .food-thumb {
        width: 72px;
        height: 54px;
        object-fit: cover;
        border-radius: 6px;
        border: 1px solid #dee2e6;
    }
    .badge-food {
        background-color: #0d6efd;
    }
    .badge-combo {
        background-color: #d97706;
    }
</style>
<script type="text/javascript">
    function openPage(pageURL) {
        window.location.href = pageURL;
    }
</script>