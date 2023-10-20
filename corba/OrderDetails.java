public class OrderDetails{
    int count_fc = 0;
    int count_cola = 0;

    int orderStatus = 0;

    float price_fc = 0;
    float price_cola = 0;

    public void setCount( int fc_count_val, int cola_count_val ){
        this.count_fc = fc_count_val;
        this.count_cola = cola_count_val;
        this.orderStatus = 1;
        this.price_fc = (float) (fc_count_val * 5.0);
        this.price_cola = (float) (cola_count_val * 1.0);
    }

    public int getFCCount(){
        return this.count_fc;
    }

    public int getColaCount(){
        return this.count_cola;
    }

    public float getTotal(){
        return (this.price_cola + this.price_fc);
    }
}