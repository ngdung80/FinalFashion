
package Model;

/**
 *
 * @author ICBAdmin
 */
public class Image {
    private int imageID;
    private int productID;
    private String imageMore;

    public Image() {
    }

    public Image(int imageID, int productID, String imageMore) {
        this.imageID = imageID;
        this.productID = productID;
        this.imageMore = imageMore;
    }

    public int getImageID() {
        return imageID;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getImageMore() {
        return imageMore;
    }

    public void setImageMore(String imageMore) {
        this.imageMore = imageMore;
    }
    
    
}
