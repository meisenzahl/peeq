using Peeq.Services;

namespace Peeq.Widgets {
	public class DatabaseListItem : Gtk.ListBoxRow {
		public string title { get; set; default = ""; }
		public string subtitle { get; set; default = "<span font_size='small'>Disconnected</span>"; }
		public string icon_name { get; set; default = "office-database"; }

		private Gtk.Image status_image;

		public DatabaseListItem (string title, string subtitle, string icon_name = "office-database") {
			Object (
				title: title,
				subtitle: @"<span font_size='small'>$(subtitle)</span>",
				icon_name: icon_name
			);
		}

		construct {
			var overlay = new Gtk.Overlay ();
			overlay.width_request = 38;

			var row_grid = new Gtk.Grid ();
			row_grid.margin = 6;
			row_grid.margin_start = 3;
			row_grid.column_spacing = 3;

			var row_image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.DND);
			row_image.pixel_size = 32;

			var row_title = new Gtk.Label (title);
      row_title.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
      row_title.ellipsize = Pango.EllipsizeMode.END;
      row_title.halign = Gtk.Align.START;
			row_title.valign = Gtk.Align.START;

			var row_description = new Gtk.Label (subtitle);
      row_description.margin_top = 2;
      row_description.use_markup = true;
      row_description.ellipsize = Pango.EllipsizeMode.END;
      row_description.halign = Gtk.Align.START;
      row_description.valign = Gtk.Align.START;

      var hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
      hbox.pack_start (row_description, false, false, 0);

      status_image = new Gtk.Image.from_icon_name ("user-offline", Gtk.IconSize.MENU);
			status_image.halign = status_image.valign = Gtk.Align.END;
		
			overlay.add (row_image);
      overlay.add_overlay (status_image);

      row_grid.attach (overlay, 0, 0, 1, 2);
      row_grid.attach (row_title, 1, 0, 1, 1);
      // row_grid.attach (hbox, 1, 1, 1, 1);

			add (row_grid);

			bind_property ("title", row_title, "label");
      bind_property ("subtitle", row_description, "label");
      bind_property ("icon-name", row_image, "icon-name");

			show_all ();
		}
	}
}