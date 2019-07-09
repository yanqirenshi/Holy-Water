class HwCard {
    constructor () {}
    pageCardDescriptionSize (request_gain, default_gain, base_size) {
        let gain = request_gain || default_gain;

        return (base_size * gain + base_size * (gain -1));
    }
}
