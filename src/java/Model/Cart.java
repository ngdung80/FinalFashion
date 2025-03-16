package Model;

import DAO.CartDAO;
import java.util.ArrayList;
import java.util.List;

public class Cart {

    private int userid;
    private List<CartItem> cartItem;

    public Cart() {
        this.cartItem = new ArrayList<>();
    }

    public Cart(int userid) {
        this.userid = userid;
        this.cartItem = new ArrayList<>();
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public List<CartItem> getCartItem() {
        return cartItem;
    }

    public void setCartItem(List<CartItem> cartItem) {
        this.cartItem = (cartItem != null) ? cartItem : new ArrayList<>();
    }

    /**
     * Adds an item to the cart. If the item already exists with the same product ID and size,
     * updates the quantity. Otherwise, adds a new item.
     *
     * @param item The item to add to the cart.
     */
    public void addItem(CartItem item) {
        CartDAO d = new CartDAO();
        ProductCart pc = d.getItemToAdd(item.getProductID());
        int availQuantity = pc.getQuantity();

        // Check if the item already exists in the cart with the same product ID and size
        for (CartItem cartItem : this.cartItem) {
            if (cartItem.getProductID() == item.getProductID() && cartItem.getSelectedSize().equals(item.getSelectedSize())) {
                int newQuantity = cartItem.getQuantity() + item.getQuantity();
                if (newQuantity > availQuantity) {
                    cartItem.setQuantity(availQuantity);
                } else {
                    cartItem.setQuantity(newQuantity);
                }
                return;
            }
        }

        // If the item doesn't exist, add it to the cart
        if (item.getQuantity() > availQuantity) {
            item.setQuantity(availQuantity);
        }
        this.cartItem.add(item);
    }

    /**
     * Updates the quantity of an item in the cart.
     *
     * @param productID The ID of the product to update.
     * @param quantity  The new quantity.
     */
    public void updateQuantityItem(int productID, int quantity) {
        for (CartItem item : cartItem) {
            if (item.getProductID() == productID) {
                item.setQuantity(quantity);
                return;
            }
        }
    }

    /**
     * Removes an item from the cart based on the product ID.
     *
     * @param productID The ID of the product to remove.
     */
    public void removeItem(int productID) {
        cartItem.removeIf(item -> item.getProductID() == productID);
    }

    /**
     * Calculates the total amount of all items in the cart.
     *
     * @return The total amount.
     */
    public int getTotalAmount() {
        int total = 0;
        for (CartItem item : cartItem) {
            total += item.getTotalPrice();
        }
        return total;
    }

    /**
     * Clears all items from the cart.
     */
    public void clearCart() {
        cartItem.clear();
    }
}