namespace Astal {
public class Slider : Gtk.Scale {
    [CCode (notify = false)]
    public bool vertical {
        get { return orientation == Gtk.Orientation.VERTICAL; }
        set { orientation = value ? Gtk.Orientation.VERTICAL : Gtk.Orientation.HORIZONTAL; }
    }

    static construct {
        set_css_name("slider");
    }

    construct {
        if (adjustment == null)
            adjustment = new Gtk.Adjustment(0,0,0,0,0,0);

        notify["orientation"].connect(() => {
            notify_property("vertical");
        });

        button_press_event.connect(() => { dragging = true; });
        key_press_event.connect(() => { dragging = true; });
        button_release_event.connect(() => { dragging = false; });
        key_release_event.connect(() => { dragging = false; });
        scroll_event.connect((event) => {
            dragging = true;
            if (event.delta_y > 0)
                value -= step;
            else
                value += step;
            dragging = false;
        });
    }

    public bool dragging { get; private set; }

    public double value {
        get { return adjustment.value; }
        set { adjustment.value = value; }
    }

    public double min {
        get { return adjustment.lower; }
        set { adjustment.lower = value; }
    }

    public double max {
        get { return adjustment.upper; }
        set { adjustment.upper = value; }
    }

    public double step {
        get { return adjustment.step_increment; }
        set { adjustment.step_increment = value; }
    }

    // TODO: marks
}
}
