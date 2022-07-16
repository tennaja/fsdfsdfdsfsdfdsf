<?php

    $servername = "localhost";
    $username = "web5_project";
    $password = "TvATHCBMpc";
    $dbname = "web5_project";
    $table = "user";

    $action = $_POST["action"];

    $conn = new mysqli($servername, $username, $password, $dbname);

    if($conn->connect_error){
        die("Connection Failed:" . $conn->connect_error);
        return;
    }

    if("CREATE_TABLE" == $action){
        $sql = "CREATE TABLE IF NOT EXISTE $table(
            user_id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            user_name VARCHAR(255) NOT NULL,
            user_surname VARCHAR(255) NOT NULL,
            user_phone VARCHAR(10) NOT NULL,
            user_email VARCHAR(255) NOT NULL,
            user_password VARCHER(255) NOT NULL,
            user_latitude VARCHER(255),
            user_longitude VARCHER(255), 
            user_role VARCHER(255)       )";

        if($conn->query($sql) == TRUE){
            echo "success";
        }
        else{
            echo "error";
        }
        $conn->close();
        return;

    }

    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT * from $table ORDER BY id DESC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("ADD_EMP" == $action){
        $user_name = $_POST['user_name'];
        $user_surname = $_POST['user_surname'];
        $user_phone = $_POST['user_phone'];
        $user_email = $_POST['user_email'];
        $user_password = $_POST['user_password'];
        $user_latitude = '';
        $user_longitude = '';
        $user_role = "customer";
        $sql = "INSERT INTO $table (user_name, user_surname, user_phone, user_email, user_password, user_role) VALUES ('$user_name','$user_surname','$user_phone','$user_email','$user_password','$user_role')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;

    }

    if("UPDATE_EMP" == $action){
        $user_id = $_POST['user_id'];
        $user_name = $_POST['user_name'];
        $user_surname = $_POST['user_surname'];
        $user_phone = $_POST['user_phone'];
        $user_email = $_POST['user_email'];
        $user_password = $_POST['user_password'];
        $sql = "UPDATE $table SET user_name = '$user_name',user_surname = '$user_surname',user_phone = '$user_phone',user_email = '$user_email', user_password = '$user_password'";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
        
    }

    if('DELETE_EMP' == $action){
        $user_id = $_POST['user_id'];
        $sql = "DELETE FROM $table WHERE id = $user_id ";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("ADD_USER_ORDER" == $action){
        $order_id = $_POST['order_id'];
        $order_by = $_POST['order_by'];
        $user_latitude = $_POST['user_latitude'];
        $user_longitude = $_POST['user_latitude'];
        $order_responsible_person = $_POST['order_responsible_person'];
        $total_price = $_POST['total_price'];
        $order_status = $_POST['order_status'];

        $sql = "INSERT INTO user_order(order_id,order_by,user_latitude,user_longitude,order_responsible_person,total_price,order_status) VALUES ('$order_id','$order_by','$user_latitude','$user_longitude','$order_responsible_person','$total_price','$order_status')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;

    }

    if("ADD_PRODUCT" == $action){
        $product_name = $_POST['product_name'];
        $product_detail = $_POST['product_detail'];
        $product_image = $_POST['product_image'];
        $product_price = $_POST['product_price'];
        $product_quantity = $_POST['product_quantity'];
        $export_product = $_POST['export_product'];
        $import_product = $_POST['import_product'];

        $sql = "INSERT INTO product(product_name,product_detail,product_image,product_price,product_quantity,export_product,import_product) VALUES ('$product_name','$product_detail','$product_image','$product_price','$product_quantity','$export_product','$import_product')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("ADD_ORDERDETAIL" == $action){
        $order_id = $_POST['order_id'];
        $product_id = $_POST['product_id'];
        $product_amount = $_POST['product_amount'];
        $product_per_pice = $_POST['product_per_pice'];
        $total = $_POST['total'];

        $sql = "INSERT INTO user_order_detail(order_id,product_id,product_amount,product_per_price,total) VALUES ('$order_id','$product_id','$product_amount','$product_per_pice','$total')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

?>