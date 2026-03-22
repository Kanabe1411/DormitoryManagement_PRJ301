package dal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Payment;

public class PaymentDAO extends DBContext {
    public List<Payment> getAll() {
        List<Payment> list = new ArrayList<>();
        try {
            String sql = "SELECT id, contractId, contract_id, amount, payment_date, status, paymentType, description FROM Payment ORDER BY payment_date DESC";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Integer cid = null;
                try { cid = rs.getObject("contractId") != null ? rs.getInt("contractId") : null; } catch (Exception e) {}
                String cidStr = null;
                try { cidStr = rs.getString("contract_id"); } catch (Exception e) {}
                if (cidStr == null && cid != null) cidStr = String.valueOf(cid);
                list.add(new Payment(
                        rs.getInt("id"),
                        cid,
                        cidStr,
                        rs.getDate("payment_date"),
                        rs.getDouble("amount"),
                        rs.getString("status"),
                        rs.getNString("paymentType"),
                        rs.getNString("description")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void insert(Payment p) {
        try {
            String sql = "INSERT INTO Payment (contractId, contract_id, amount, payment_date, status, paymentType, description) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setObject(1, p.getContractId());
            st.setString(2, p.getContractIdStr() != null ? p.getContractIdStr() : (p.getContractId() != null ? String.valueOf(p.getContractId()) : ""));
            st.setDouble(3, p.getAmount());
            st.setDate(4, p.getDate());
            st.setString(5, p.getStatus());
            st.setNString(6, p.getPaymentType() != null ? p.getPaymentType() : "Tiền trọ");
            st.setNString(7, p.getDescription());
            st.executeUpdate();
        } catch (SQLException e) { System.out.println(e); }
    }

    public void delete(int id) {
        try {
            String sql = "DELETE FROM Payment WHERE id=?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}