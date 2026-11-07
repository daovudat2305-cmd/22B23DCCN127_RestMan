<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f8f6f2;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #2c2523;
    }
    .restman-navbar {
        background: linear-gradient(135deg, #1f1c18 0%, #8e0e00 100%);
        box-shadow: 0 4px 12px rgba(0,0,0,0.18);
    }
    .restman-card {
        background: #ffffff;
        border: none;
        border-radius: 14px;
        box-shadow: 0 6px 24px rgba(0,0,0,0.06);
    }
    .btn-restman {
        background-color: #8e0e00;
        color: #fff;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.2s;
    }
    .btn-restman:hover {
        background-color: #6b0a00;
        color: #fff;
        transform: translateY(-1px);
    }
    .table-restman thead {
        background-color: #2c2523;
        color: #ffffff;
    }
    .food-thumb {
        width: 72px;
        height: 54px;
        object-fit: cover;
        border-radius: 8px;
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