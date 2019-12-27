//
// UIColor+NamedColors.swift
//
//
// Created by Sketch Export for Xcode on 26 December 2019
// Exported from file Android GUI - Design Files.sketch
//

import UIKit

extension UIColor {
	// MARK: - Document Layer Styles

	static var cardLight: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "cardLight") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}

	static var dialogLight: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "dialogLight") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}

	static var primaryActionColor: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "primaryActionColor") ?? .white
		} else {
			return UIColor(red: 0.9411765, green: 0.6784314, blue: 0.14117648, alpha: 1.0)
		}
	}

	static var iconDark: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "iconDark") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
		}
	}

	static var dividerLight: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "dividerLight") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12)
		}
	}

	static var linked: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "linked") ?? .white
		} else {
			return UIColor(red: 0.5115327, green: 0.5115327, blue: 0.5115327, alpha: 1.0)
		}
	}

	static var iconDarkDisabled: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "iconDarkDisabled") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
		}
	}

	static var iconWhite: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "iconWhite") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}

	static var toolbarShadow: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "toolbarShadow") ?? .white
		} else {
			return UIColor(red: 0.40392157, green: 0.22745098, blue: 0.7176471, alpha: 1.0)
		}
	}

	static var black: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "black") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
		}
	}

	static var menuLight: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "menuLight") ?? .white
		} else {
			return UIColor(red: 0.98039216, green: 0.98039216, blue: 0.98039216, alpha: 1.0)
		}
	}

	static var toast: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "toast") ?? .white
		} else {
			return UIColor(red: 0.19607843, green: 0.19607843, blue: 0.19607843, alpha: 1.0)
		}
	}

	static var fabButton: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "fabButton") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.34117648, blue: 0.13333334, alpha: 1.0)
		}
	}

	static var iconWhiteDisabled: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "iconWhiteDisabled") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.54)
		}
	}

	static var searchBox: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "searchBox") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}

	static var scrimBottom: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "scrimBottom") ?? .white
		} else {
			return UIColor(red: 0.25882354, green: 0.25882354, blue: 0.25882354, alpha: 0.5)
		}
	}

	static var sheetLight: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "sheetLight") ?? .white
		} else {
			return UIColor(red: 0.98039216, green: 0.98039216, blue: 0.98039216, alpha: 1.0)
		}
	}

	static var scrimUpper: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "scrimUpper") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
		}
	}


	// MARK: - Document Colors

	static var blackAlpha38: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackAlpha38") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.38)
		}
	}

	static var purpleSpot: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "purpleSpot") ?? .white
		} else {
			return UIColor(red: 0.40392157, green: 0.22745098, blue: 0.7176471, alpha: 1.0)
		}
	}

	static var illustriousIndigo: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "illustriousIndigo") ?? .white
		} else {
			return UIColor(red: 0.31764707, green: 0.1764706, blue: 0.65882355, alpha: 1.0)
		}
	}

	static var superSilver: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "superSilver") ?? .white
		} else {
			return UIColor(red: 0.93333334, green: 0.93333334, blue: 0.93333334, alpha: 1.0)
		}
	}

	static var blackAlpha20: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackAlpha20") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
		}
	}

	static var drWhite: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "drWhite") ?? .white
		} else {
			return UIColor(red: 0.98039216, green: 0.98039216, blue: 0.98039216, alpha: 1.0)
		}
	}

	static var elemental: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "elemental") ?? .white
		} else {
			return UIColor(red: 0.81960785, green: 0.827451, blue: 0.83137256, alpha: 1.0)
		}
	}

	static var whiteSmoke: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteSmoke") ?? .white
		} else {
			return UIColor(red: 0.9607843, green: 0.9607843, blue: 0.9607843, alpha: 1.0)
		}
	}

	static var blackAlpha87: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackAlpha87") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.87)
		}
	}

	static var nasturcianFlower: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "nasturcianFlower") ?? .white
		} else {
			return UIColor(red: 0.9019608, green: 0.2901961, blue: 0.09803922, alpha: 1.0)
		}
	}

	static var whiteAlpha38: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha38") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.38)
		}
	}

	static var blackAlpha12: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackAlpha12") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12)
		}
	}

	static var whiteAlpha87: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha87") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.87)
		}
	}

	static var blackCat: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackCat") ?? .white
		} else {
			return UIColor(red: 0.1882353, green: 0.1882353, blue: 0.1882353, alpha: 1.0)
		}
	}

	static var lead: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "lead") ?? .white
		} else {
			return UIColor(red: 0.12941177, green: 0.12941177, blue: 0.12941177, alpha: 1.0)
		}
	}

	static var whiteAlpha54: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha54") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.54)
		}
	}

	static var christmasSilver: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "christmasSilver") ?? .white
		} else {
			return UIColor(red: 0.8784314, green: 0.8784314, blue: 0.8784314, alpha: 1.0)
		}
	}

	static var blackPanther: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackPanther") ?? .white
		} else {
			return UIColor(red: 0.25882354, green: 0.25882354, blue: 0.25882354, alpha: 1.0)
		}
	}

	static var blackAlpha54: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackAlpha54") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.54)
		}
	}

	static var giantsOrange: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "giantsOrange") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.34117648, blue: 0.13333334, alpha: 1.0)
		}
	}


	// MARK: - Material GUI 

	static var gunmetalGrey: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "gunmetalGrey") ?? .white
		} else {
			return UIColor(red: 0.49806303, green: 0.5440895, blue: 0.55844414, alpha: 1.0)
		}
	}

	static var gorgonzolaBlue1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "gorgonzolaBlue1") ?? .white
		} else {
			return UIColor(red: 0.27450982, green: 0.36078432, blue: 0.81960785, alpha: 1.0)
		}
	}

	static var digitalViolets: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "digitalViolets") ?? .white
		} else {
			return UIColor(red: 0.6666667, green: 0.0, blue: 1.0, alpha: 1.0)
		}
	}

	static var chiGong: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "chiGong") ?? .white
		} else {
			return UIColor(red: 0.83137256, green: 0.16470589, blue: 0.16470589, alpha: 1.0)
		}
	}

	static var glitterShower: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "glitterShower") ?? .white
		} else {
			return UIColor(red: 0.5411765, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}

	static var lynxWhite: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "lynxWhite") ?? .white
		} else {
			return UIColor(red: 0.9647059, green: 0.96862745, blue: 0.972549, alpha: 1.0)
		}
	}

	static var punch2: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "punch2") ?? .white
		} else {
			return UIColor(red: 0.85882354, green: 0.26666668, blue: 0.21568628, alpha: 1.0)
		}
	}

	static var punch: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "punch") ?? .white
		} else {
			return UIColor(red: 0.85882354, green: 0.26666668, blue: 0.21176471, alpha: 1.0)
		}
	}

	static var boldEagle: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "boldEagle") ?? .white
		} else {
			return UIColor(red: 0.27058825, green: 0.25490198, blue: 0.19215687, alpha: 1.0)
		}
	}

	static var giantsOrangeAlpha24: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "giantsOrangeAlpha24") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.34117648, blue: 0.13333334, alpha: 0.24000001)
		}
	}

	static var masuhanaBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "masuhanaBlue") ?? .white
		} else {
			return UIColor(red: 0.29803923, green: 0.39215687, blue: 0.43529412, alpha: 1.0)
		}
	}

	static var butterscotchBliss: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "butterscotchBliss") ?? .white
		} else {
			return UIColor(red: 0.8509804, green: 0.67058825, blue: 0.39215687, alpha: 1.0)
		}
	}

	static var cantaloupe: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "cantaloupe") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.827451, blue: 0.4862745, alpha: 1.0)
		}
	}

	static var jupiter: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "jupiter") ?? .white
		} else {
			return UIColor(red: 0.88235295, green: 0.88235295, blue: 0.88235295, alpha: 1.0)
		}
	}

	static var blueViolet1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blueViolet1") ?? .white
		} else {
			return UIColor(red: 0.24705882, green: 0.31764707, blue: 0.70980394, alpha: 1.0)
		}
	}

	static var yuèGuāngLánBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "yuèGuāngLánBlue") ?? .white
		} else {
			return UIColor(red: 0.10980392, green: 0.22745098, blue: 0.6627451, alpha: 1.0)
		}
	}

	static var knightsArmor: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "knightsArmor") ?? .white
		} else {
			return UIColor(red: 0.35686275, green: 0.36078432, blue: 0.3647059, alpha: 1.0)
		}
	}

	static var ginshu: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "ginshu") ?? .white
		} else {
			return UIColor(red: 0.7254902, green: 0.19607843, blue: 0.12941177, alpha: 1.0)
		}
	}

	static var lynxScreenBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "lynxScreenBlue") ?? .white
		} else {
			return UIColor(red: 0.18431373, green: 0.6627451, blue: 0.89411765, alpha: 1.0)
		}
	}

	static var shamrock: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "shamrock") ?? .white
		} else {
			return UIColor(red: 0.047058824, green: 0.6156863, blue: 0.34509805, alpha: 1.0)
		}
	}

	static var valiantPoppy: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "valiantPoppy") ?? .white
		} else {
			return UIColor(red: 0.7254902, green: 0.20392157, blue: 0.14901961, alpha: 1.0)
		}
	}

	static var middleBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "middleBlue") ?? .white
		} else {
			return UIColor(red: 0.5058824, green: 0.8235294, blue: 0.92156863, alpha: 1.0)
		}
	}

	static var chineseOrange: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "chineseOrange") ?? .white
		} else {
			return UIColor(red: 0.9529412, green: 0.4392157, blue: 0.2784314, alpha: 1.0)
		}
	}

	static var bielTanGreen: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "bielTanGreen") ?? .white
		} else {
			return UIColor(red: 0.06666667, green: 0.65882355, blue: 0.38039216, alpha: 1.0)
		}
	}

	static var kettleman: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "kettleman") ?? .white
		} else {
			return UIColor(red: 0.3764706, green: 0.3764706, blue: 0.3764706, alpha: 1.0)
		}
	}

	static var turmericRoot: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "turmericRoot") ?? .white
		} else {
			return UIColor(red: 0.9843137, green: 0.67058825, blue: 0.039215688, alpha: 1.0)
		}
	}

	static var porpoise: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "porpoise") ?? .white
		} else {
			return UIColor(red: 0.85882354, green: 0.85882354, blue: 0.85882354, alpha: 1.0)
		}
	}

	static var bootyBay: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "bootyBay") ?? .white
		} else {
			return UIColor(red: 0.5019608, green: 0.79607844, blue: 0.76862746, alpha: 1.0)
		}
	}

	static var sorxRed: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "sorxRed") ?? .white
		} else {
			return UIColor(red: 0.9607843, green: 0.0, blue: 0.34117648, alpha: 1.0)
		}
	}

	static var emeraldWave: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "emeraldWave") ?? .white
		} else {
			return UIColor(red: 0.3019608, green: 0.7137255, blue: 0.6745098, alpha: 1.0)
		}
	}

	static var princetonOrange: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "princetonOrange") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.56078434, blue: 0.003921569, alpha: 1.0)
		}
	}

	static var whaleShark: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whaleShark") ?? .white
		} else {
			return UIColor(red: 0.3764706, green: 0.49019608, blue: 0.54509807, alpha: 1.0)
		}
	}

	static var gorgonzolaBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "gorgonzolaBlue") ?? .white
		} else {
			return UIColor(red: 0.26666668, green: 0.3529412, blue: 0.7921569, alpha: 1.0)
		}
	}

	static var sonicSilver: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "sonicSilver") ?? .white
		} else {
			return UIColor(red: 0.45882353, green: 0.45882353, blue: 0.45882353, alpha: 1.0)
		}
	}

	static var crystalBell: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "crystalBell") ?? .white
		} else {
			return UIColor(red: 0.9372549, green: 0.9372549, blue: 0.9372549, alpha: 1.0)
		}
	}

	static var lǜSèGreen: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "lǜSèGreen") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.78431374, blue: 0.3254902, alpha: 1.0)
		}
	}

	static var whiteAlpha40: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha40") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
		}
	}

	static var goBananas: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "goBananas") ?? .white
		} else {
			return UIColor(red: 0.9607843, green: 0.78431374, blue: 0.30588236, alpha: 1.0)
		}
	}

	static var reddishPink: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "reddishPink") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.18039216, blue: 0.34509805, alpha: 1.0)
		}
	}

	static var carbonAlpha50: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "carbonAlpha50") ?? .white
		} else {
			return UIColor(red: 0.19607843, green: 0.19607843, blue: 0.19607843, alpha: 0.5024626)
		}
	}

	static var sasquatchSocks: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "sasquatchSocks") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.25490198, blue: 0.50980395, alpha: 1.0)
		}
	}

	static var surfWash: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "surfWash") ?? .white
		} else {
			return UIColor(red: 0.5019608, green: 0.8039216, blue: 0.7764706, alpha: 1.0)
		}
	}

	static var blueViolet: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blueViolet") ?? .white
		} else {
			return UIColor(red: 0.24705882, green: 0.30980393, blue: 0.7176471, alpha: 1.0)
		}
	}

	static var oceanBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "oceanBlue") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.62352943, blue: 0.78039217, alpha: 1.0)
		}
	}

	static var kettleman2: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "kettleman2") ?? .white
		} else {
			return UIColor(red: 0.38039216, green: 0.38039216, blue: 0.38039216, alpha: 1.0)
		}
	}

	static var mellowMelon: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "mellowMelon") ?? .white
		} else {
			return UIColor(red: 0.9137255, green: 0.11764706, blue: 0.3882353, alpha: 1.0)
		}
	}

	static var appleIiMagenta: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "appleIiMagenta") ?? .white
		} else {
			return UIColor(red: 0.8745098, green: 0.2509804, blue: 0.99215686, alpha: 1.0)
		}
	}

	static var aragonGreen: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "aragonGreen") ?? .white
		} else {
			return UIColor(red: 0.29803923, green: 0.7137255, blue: 0.5176471, alpha: 1.0)
		}
	}

	static var blackPearl: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackPearl") ?? .white
		} else {
			return UIColor(red: 0.11372549, green: 0.14901961, blue: 0.16862746, alpha: 1.0)
		}
	}

	static var deepDenim: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "deepDenim") ?? .white
		} else {
			return UIColor(red: 0.39607844, green: 0.5137255, blue: 0.99607843, alpha: 1.0)
		}
	}

	static var preciousPearls: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "preciousPearls") ?? .white
		} else {
			return UIColor(red: 0.94509804, green: 0.94509804, blue: 0.94509804, alpha: 1.0)
		}
	}

	static var moreThanAWeek: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "moreThanAWeek") ?? .white
		} else {
			return UIColor(red: 0.54901963, green: 0.54901963, blue: 0.54901963, alpha: 1.0)
		}
	}

	static var fluorescentRed: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "fluorescentRed") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.32156864, blue: 0.3254902, alpha: 1.0)
		}
	}

	static var pervenche1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "pervenche1") ?? .white
		} else {
			return UIColor(red: 0.011764706, green: 0.60784316, blue: 0.8980392, alpha: 1.0)
		}
	}

	static var whiteAlpha50: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha50") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
		}
	}

	static var springThaw: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "springThaw") ?? .white
		} else {
			return UIColor(red: 0.85490197, green: 0.87058824, blue: 0.87058824, alpha: 1.0)
		}
	}

	static var blueMartini: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blueMartini") ?? .white
		} else {
			return UIColor(red: 0.3254902, green: 0.7294118, blue: 0.83137256, alpha: 1.0)
		}
	}

	static var eggYolkYellow2: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "eggYolkYellow2") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.8235294, blue: 0.5137255, alpha: 1.0)
		}
	}

	static var whiteAlpha161: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha161") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.16000001)
		}
	}

	static var rebelRed: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "rebelRed") ?? .white
		} else {
			return UIColor(red: 0.8235294, green: 0.24705882, blue: 0.1882353, alpha: 1.0)
		}
	}

	static var whiteEdgar: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteEdgar") ?? .white
		} else {
			return UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1.0)
		}
	}

	static var bleachedSilk: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "bleachedSilk") ?? .white
		} else {
			return UIColor(red: 0.9490196, green: 0.9490196, blue: 0.9490196, alpha: 1.0)
		}
	}

	static var englishWalnutAlpha20: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "englishWalnutAlpha20") ?? .white
		} else {
			return UIColor(red: 0.24313726, green: 0.15294118, blue: 0.13725491, alpha: 0.2)
		}
	}

	static var bielTanGreen1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "bielTanGreen1") ?? .white
		} else {
			return UIColor(red: 0.08627451, green: 0.654902, blue: 0.39607844, alpha: 1.0)
		}
	}

	static var blackAlpha26: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackAlpha26") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.26)
		}
	}

	static var dazzlingBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "dazzlingBlue") ?? .white
		} else {
			return UIColor(red: 0.22611512, green: 0.28161696, blue: 0.6423788, alpha: 1.0)
		}
	}

	static var eggYolkYellow: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "eggYolkYellow") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.81960785, blue: 0.5137255, alpha: 1.0)
		}
	}

	static var firstOfJuly: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "firstOfJuly") ?? .white
		} else {
			return UIColor(red: 0.73333335, green: 0.90588236, blue: 0.9490196, alpha: 1.0)
		}
	}

	static var azulPetróleoAlpha50: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "azulPetróleoAlpha50") ?? .white
		} else {
			return UIColor(red: 0.21568628, green: 0.2784314, blue: 0.30980393, alpha: 0.5)
		}
	}

	static var chimneySweepAlpha59: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "chimneySweepAlpha59") ?? .white
		} else {
			return UIColor(red: 0.15294118, green: 0.18431373, blue: 0.20784314, alpha: 0.59999996)
		}
	}

	static var blueRadiance: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blueRadiance") ?? .white
		} else {
			return UIColor(red: 0.3019608, green: 0.8156863, blue: 0.88235295, alpha: 1.0)
		}
	}

	static var akebiPurple: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "akebiPurple") ?? .white
		} else {
			return UIColor(red: 0.5764706, green: 0.23921569, blue: 0.6627451, alpha: 1.0)
		}
	}

	static var safflowerishSky: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "safflowerishSky") ?? .white
		} else {
			return UIColor(red: 0.5176471, green: 0.5647059, blue: 0.78431374, alpha: 1.0)
		}
	}

	static var abaddonBlackAlpha26: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "abaddonBlackAlpha26") ?? .white
		} else {
			return UIColor(red: 0.13333334, green: 0.12156863, blue: 0.12156863, alpha: 0.26)
		}
	}

	static var necronCompound1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "necronCompound1") ?? .white
		} else {
			return UIColor(red: 0.49803922, green: 0.5411765, blue: 0.56078434, alpha: 1.0)
		}
	}

	static var lineage: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "lineage") ?? .white
		} else {
			return UIColor(red: 0.3019608, green: 0.20392157, blue: 0.18431373, alpha: 1.0)
		}
	}

	static var mattBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "mattBlue") ?? .white
		} else {
			return UIColor(red: 0.20784314, green: 0.41568628, blue: 0.7647059, alpha: 1.0)
		}
	}

	static var chickadee: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "chickadee") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.8117647, blue: 0.3882353, alpha: 1.0)
		}
	}

	static var fernGreen: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "fernGreen") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.53333336, blue: 0.27450982, alpha: 1.0)
		}
	}

	static var larkspurBud: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "larkspurBud") ?? .white
		} else {
			return UIColor(red: 0.714006, green: 0.75237304, blue: 0.9096779, alpha: 1.0)
		}
	}

	static var white: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "white") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}

	static var honeyWax1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "honeyWax1") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.654902, blue: 0.14901961, alpha: 1.0)
		}
	}

	static var madeOfSteel: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "madeOfSteel") ?? .white
		} else {
			return UIColor(red: 0.3529412, green: 0.40392157, blue: 0.43137255, alpha: 1.0)
		}
	}

	static var seljukBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "seljukBlue") ?? .white
		} else {
			return UIColor(red: 0.25882354, green: 0.52156866, blue: 0.95686275, alpha: 1.0)
		}
	}

	static var smokedPearl: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "smokedPearl") ?? .white
		} else {
			return UIColor(red: 0.3882353, green: 0.3882353, blue: 0.3882353, alpha: 1.0)
		}
	}

	static var azulPetróleo1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "azulPetróleo1") ?? .white
		} else {
			return UIColor(red: 0.21176471, green: 0.2784314, blue: 0.30980393, alpha: 1.0)
		}
	}

	static var psychedelicPurple: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "psychedelicPurple") ?? .white
		} else {
			return UIColor(red: 0.8392157, green: 0.0, blue: 0.972549, alpha: 1.0)
		}
	}

	static var tinSoldier: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "tinSoldier") ?? .white
		} else {
			return UIColor(red: 0.7492294, green: 0.7492294, blue: 0.7492294, alpha: 1.0)
		}
	}

	static var capeHope: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "capeHope") ?? .white
		} else {
			return UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1.0)
		}
	}

	static var gilneasGrey: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "gilneasGrey") ?? .white
		} else {
			return UIColor(red: 0.42352942, green: 0.52156866, blue: 0.57254905, alpha: 1.0)
		}
	}

	static var mayaBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "mayaBlue") ?? .white
		} else {
			return UIColor(red: 0.43529412, green: 0.7490196, blue: 0.95686275, alpha: 1.0)
		}
	}

	static var coralHaze: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "coralHaze") ?? .white
		} else {
			return UIColor(red: 0.8980392, green: 0.5647059, blue: 0.5372549, alpha: 1.0)
		}
	}

	static var blackAlpha50: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackAlpha50") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
		}
	}

	static var báiSèWhite: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "báiSèWhite") ?? .white
		} else {
			return UIColor(red: 0.9254902, green: 0.9372549, blue: 0.9411765, alpha: 1.0)
		}
	}

	static var whiteAlpha0: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha0") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
		}
	}

	static var punch1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "punch1") ?? .white
		} else {
			return UIColor(red: 0.859, green: 0.267, blue: 0.216, alpha: 1.0)
		}
	}

	static var whiteAlyssum: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlyssum") ?? .white
		} else {
			return UIColor(red: 0.9372549, green: 0.9254902, blue: 0.90588236, alpha: 1.0)
		}
	}

	static var hornblende: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "hornblende") ?? .white
		} else {
			return UIColor(red: 0.20784314, green: 0.13333334, blue: 0.11764706, alpha: 1.0)
		}
	}

	static var stormGreen: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "stormGreen") ?? .white
		} else {
			return UIColor(red: 0.047058824, green: 0.2, blue: 0.23921569, alpha: 1.0)
		}
	}

	static var venetianNights: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "venetianNights") ?? .white
		} else {
			return UIColor(red: 0.48235294, green: 0.3019608, blue: 1.0, alpha: 1.0)
		}
	}

	static var honeyWax: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "honeyWax") ?? .white
		} else {
			return UIColor(red: 0.972549, green: 0.65882355, blue: 0.14509805, alpha: 1.0)
		}
	}

	static var brotherBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "brotherBlue") ?? .white
		} else {
			return UIColor(red: 0.6862745, green: 0.72156864, blue: 0.78039217, alpha: 1.0)
		}
	}

	static var boldIrish: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "boldIrish") ?? .white
		} else {
			return UIColor(red: 0.12941177, green: 0.49803922, blue: 0.30588236, alpha: 1.0)
		}
	}

	static var middleYellow: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "middleYellow") ?? .white
		} else {
			return UIColor(red: 1.0, green: 0.91764706, blue: 0.0, alpha: 1.0)
		}
	}

	static var krishnaBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "krishnaBlue") ?? .white
		} else {
			return UIColor(red: 0.03529412, green: 0.6745098, blue: 0.99215686, alpha: 1.0)
		}
	}

	static var approvalGreen: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "approvalGreen") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.5882353, blue: 0.53333336, alpha: 1.0)
		}
	}

	static var necronCompound: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "necronCompound") ?? .white
		} else {
			return UIColor(red: 0.49803922, green: 0.54509807, blue: 0.56078434, alpha: 1.0)
		}
	}

	static var whiteAlpha16: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha16") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.16)
		}
	}

	static var azulPetróleo: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "azulPetróleo") ?? .white
		} else {
			return UIColor(red: 0.21568628, green: 0.2784314, blue: 0.30980393, alpha: 1.0)
		}
	}

	static var quietGrey: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "quietGrey") ?? .white
		} else {
			return UIColor(red: 0.7137255, green: 0.7294118, blue: 0.7372549, alpha: 1.0)
		}
	}

	static var morroBay: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "morroBay") ?? .white
		} else {
			return UIColor(red: 0.32941177, green: 0.43137255, blue: 0.47843137, alpha: 1.0)
		}
	}

	static var suaveGrey: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "suaveGrey") ?? .white
		} else {
			return UIColor(red: 0.8117647, green: 0.84705883, blue: 0.8627451, alpha: 1.0)
		}
	}

	static var vividOrchid: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "vividOrchid") ?? .white
		} else {
			return UIColor(red: 0.83137256, green: 0.0, blue: 0.98039216, alpha: 1.0)
		}
	}

	static var summerSkyAlpha20: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "summerSkyAlpha20") ?? .white
		} else {
			return UIColor(red: 0.2, green: 0.70980394, blue: 0.8980392, alpha: 0.2)
		}
	}

	static var megaman: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "megaman") ?? .white
		} else {
			return UIColor(red: 0.2509804, green: 0.7647059, blue: 1.0, alpha: 1.0)
		}
	}

	static var freesia: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "freesia") ?? .white
		} else {
			return UIColor(red: 0.9647059, green: 0.7490196, blue: 0.14901961, alpha: 1.0)
		}
	}

	static var coastalBreeze: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "coastalBreeze") ?? .white
		} else {
			return UIColor(red: 0.88235295, green: 0.9607843, blue: 0.98039216, alpha: 1.0)
		}
	}

	static var plunder: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "plunder") ?? .white
		} else {
			return UIColor(red: 0.32941177, green: 0.42352942, blue: 0.6627451, alpha: 1.0)
		}
	}

	static var andreaBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "andreaBlue") ?? .white
		} else {
			return UIColor(red: 0.21568628, green: 0.46666667, blue: 0.8901961, alpha: 1.0)
		}
	}

	static var tileBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "tileBlue") ?? .white
		} else {
			return UIColor(red: 0.003921569, green: 0.50980395, blue: 0.56078434, alpha: 1.0)
		}
	}

	static var blackPantherAlpha50: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackPantherAlpha50") ?? .white
		} else {
			return UIColor(red: 0.25882354, green: 0.25882354, blue: 0.25882354, alpha: 0.5)
		}
	}

	static var báiSèWhite1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "báiSèWhite1") ?? .white
		} else {
			return UIColor(red: 0.9254902, green: 0.9372549, blue: 0.94509804, alpha: 1.0)
		}
	}

	static var seljukBlueAlpha10: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "seljukBlueAlpha10") ?? .white
		} else {
			return UIColor(red: 0.25882354, green: 0.52156866, blue: 0.95686275, alpha: 0.1)
		}
	}

	static var highBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "highBlue") ?? .white
		} else {
			return UIColor(red: 0.30588236, green: 0.6862745, blue: 0.8627451, alpha: 1.0)
		}
	}

	static var ceruleanBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "ceruleanBlue") ?? .white
		} else {
			return UIColor(red: 0.16470589, green: 0.3372549, blue: 0.7764706, alpha: 1.0)
		}
	}

	static var chimneySweep: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "chimneySweep") ?? .white
		} else {
			return UIColor(red: 0.14901961, green: 0.19607843, blue: 0.21960784, alpha: 1.0)
		}
	}

	static var eggYolkYellow1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "eggYolkYellow1") ?? .white
		} else {
			return UIColor(red: 0.99607843, green: 0.8235294, blue: 0.5058824, alpha: 1.0)
		}
	}

	static var wispOfSmoke: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "wispOfSmoke") ?? .white
		} else {
			return UIColor(red: 0.89411765, green: 0.90588236, blue: 0.9137255, alpha: 1.0)
		}
	}

	static var summerSky: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "summerSky") ?? .white
		} else {
			return UIColor(red: 0.2, green: 0.70980394, blue: 0.8980392, alpha: 1.0)
		}
	}

	static var beSpontaneous: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "beSpontaneous") ?? .white
		} else {
			return UIColor(red: 0.6117647, green: 0.8, blue: 0.39607844, alpha: 1.0)
		}
	}

	static var oceanBoatBlue: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "oceanBoatBlue") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.4627451, blue: 0.7490196, alpha: 1.0)
		}
	}

	static var kettleman1: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "kettleman1") ?? .white
		} else {
			return UIColor(red: 0.38431373, green: 0.38431373, blue: 0.38431373, alpha: 1.0)
		}
	}

	static var pervenche: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "pervenche") ?? .white
		} else {
			return UIColor(red: 0.003921569, green: 0.6039216, blue: 0.9098039, alpha: 1.0)
		}
	}

	static var coldGrey: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "coldGrey") ?? .white
		} else {
			return UIColor(red: 0.627365, green: 0.627365, blue: 0.627365, alpha: 1.0)
		}
	}

	static var kingfisherSheen: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "kingfisherSheen") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.5058824, blue: 0.6313726, alpha: 1.0)
		}
	}


	// MARK: - Symbols

	static var whiteAlpha70: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha70") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
		}
	}

	static var whiteAlpha12: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha12") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.12)
		}
	}

	static var vantablack: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "vantablack") ?? .white
		} else {
			return UIColor(red: 0.003921569, green: 0.003921569, blue: 0.003921569, alpha: 1.0)
		}
	}

	static var whiteAlpha30: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha30") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
		}
	}

	static var blackAlpha60: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "blackAlpha60") ?? .white
		} else {
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
		}
	}

	static var verdigris: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "verdigris") ?? .white
		} else {
			return UIColor(red: 0.2784314, green: 0.7137255, blue: 0.6784314, alpha: 1.0)
		}
	}

	static var cerebralGreyAlpha25: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "cerebralGreyAlpha25") ?? .white
		} else {
			return UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.25)
		}
	}

	static var carbon: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "carbon") ?? .white
		} else {
			return UIColor(red: 0.19607843, green: 0.19607843, blue: 0.19607843, alpha: 1.0)
		}
	}

	static var violetVelvet: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "violetVelvet") ?? .white
		} else {
			return UIColor(red: 0.7019608, green: 0.6156863, blue: 0.85882354, alpha: 1.0)
		}
	}

	static var basaltGreyAlpha40: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "basaltGreyAlpha40") ?? .white
		} else {
			return UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.4)
		}
	}

	static var whiteAlpha20: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "whiteAlpha20") ?? .white
		} else {
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
		}
	}

	static var noqreiSilver: UIColor {
		if #available(iOS 11.0, *) {
			return UIColor(named: "noqreiSilver") ?? .white
		} else {
			return UIColor(red: 0.7411765, green: 0.7411765, blue: 0.7411765, alpha: 1.0)
		}
	}


}
